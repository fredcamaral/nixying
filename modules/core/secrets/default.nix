{
  config,
  host,
  ...
}: {
  age = {
    identityPaths = ["${config.users.users.fredamaral.home}/repos/.secrets/${host}.txt"];

    secrets."${hostname}-tailscale-auth" = {
      file = "${config.users.users.fredamaral.home}/repos/.secrets/${host}-tailscale-auth.age";

      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
