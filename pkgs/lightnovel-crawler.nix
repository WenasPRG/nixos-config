{ lib, python3, fetchFromGitHub }:

python3.pkgs.buildPythonApplication rec {
  pname = "lightnovel-crawler";
  version = "3.7.2"; # Replace with the latest version

  src = fetchFromGitHub {
    owner = "dipu-bd";
    repo = "lightnovel-crawler";
    rev = "v${version}";
    sha256 = ""; # You'll need to fill this in
  };

  propagatedBuildInputs = with python3.pkgs; [
    ascii
    regex
    packaging
    pyease-grpc
    python-dotenv
    beautifulsoup4
    requests
    python-slugify
    colorama
    tqdm
    js2py
    ebooklib
    pillow
    cloudscraper
    lxml
    questionary
    prompt-toolkit
    html5lib
    base58
    python-box
    pycryptodome
    webdriver-manager
    selenium
    undetected-chromedriver
    readability-lxml
  ];

  # If there are any necessary build inputs, add them here
  nativeBuildInputs = [ ];

  # If there are any tests, you can enable them like this:
  # checkInputs = [ ];
  # doCheck = true;

  meta = with lib; {
    description = "Download lightnovels from various online sources";
    homepage = "https://github.com/dipu-bd/lightnovel-crawler";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ ]; # Add yourself here
  };
}
