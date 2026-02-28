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
  version = "20250629";
  src = fetchFromGitea {
    domain = "codeberg.org";
    owner = "MonadicSheep";
    repo = "emacs-reader";
    rev = "9edf8a97986894e7abc69f44159c3685e89049dd"; # replace with 'version' for stable
    hash = "sha256-BpuWWGt46BVgQZPHzeLEbzT+ooR4v29R+1Lv0K55kK8=";
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
