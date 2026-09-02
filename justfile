# nix doesn't allow relative path during pure build
prep:
    mkdir -p .build /var/tmp/nixos-vmtest-persist
    ln -sf /var/tmp/nixos-vmtest-persist .build/persist

build_vm: prep
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vm

build_vmWithDisko: prep
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vmWithDisko


build_vmWithBootLoader: prep
    cd .build && nix build ../nix#nixosConfigurations.vmtest.config.system.build.vmWithBootLoader


run:
    cd .build && ./result/bin/*-vm

vm: build_vm run

vmWithDisko: build_vmWithDisko run

vmWithBootLoader: build_vmWithBootLoader run

clean:
    unlink .build/persist; rm -r .build /var/tmp/nixos-vmtest-persist
