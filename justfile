build_vm:
    mkdir -p .build
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vm

build_vmWithDisko:
    mkdir -p .build
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vmWithDisko


build_vmWithBootLoader:
    mkdir -p .build
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vmWithBootLoader


run:
    cd .build && ./result/bin/run-*-vm

vm: build_vm run

vmWithDisko: build_vmWithDisko run

vmWithBootLoader: build_vmWithBootLoader run

clean:
    rm -r .build
