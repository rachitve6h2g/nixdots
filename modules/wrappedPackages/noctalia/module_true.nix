{ self, ... }:
{
  flake.wrappers.noctalia-mine =
    { ... }:
    {
      imports = [ self.wrapperModules.noctalia ];
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];

        states = {
          pomodoro = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
      };
    };
}
