{
  melpaBuild,
  fetchFromGitea,
  pkg-config,
  gcc,
  mupdf,
  gnumake,
}:

melpaBuild {
  ename = "reader";
  pname = "emacs-reader";
  version = "20260213";
  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "MonadicSheep";
    repo = "emacs-reader";
    rev = "3b9628f56cc991219074d27c3faeb5a44035fa44"; # replace with 'version' for stable
    hash = "sha256-cn5eqnra3cXx6WdNG7Y34e+XhWz9KSWZ7I5t2nqc3A0=";
  };
  files = ''(:defaults "render-core.so")'';
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [
    gcc
    mupdf
    gnumake
    pkg-config
  ];
  preBuild = "make clean all";
}
