{...}:
{
  # buggy sleep firmware so we will only use hibernation
  systemd.sleep.settings.Sleep = {
    AllowSuspend = "no";
    AllowHybridSleep = "no";
    AllowSuspendThenHibernate = "no";
    HibernateMode = "shutdown";
  };

  services.logind.settings.Login = {
    HandleSuspendKey = "hibernate";
    HandleLidSwitch = "hibernate";
  };
}
