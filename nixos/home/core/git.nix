{
  pkgs,
  meta,
  ...
}: {
  programs.git = {
    enable = true;
    userName =
      if meta.isWork
      then "Maximilian Troester"
      else "yumo4";
    userEmail =
      if meta.isWork
      then "maximilian.troester@flyeralarm.com"
      else "maximilian.troe@gmail.com";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
