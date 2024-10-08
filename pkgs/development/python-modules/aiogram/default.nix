{
  lib,
  aiofiles,
  aiohttp,
  aiohttp-socks,
  aresponses,
  babel,
  buildPythonPackage,
  certifi,
  fetchFromGitHub,
  gitUpdater,
  hatchling,
  magic-filter,
  motor,
  pycryptodomex,
  pydantic,
  pymongo,
  pytest-aiohttp,
  pytest-asyncio,
  pytest-lazy-fixture,
  pytestCheckHook,
  pythonOlder,
  pytz,
  redis,
}:

buildPythonPackage rec {
  pname = "aiogram";
  version = "3.12.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "aiogram";
    repo = "aiogram";
    rev = "refs/tags/v${version}";
    hash = "sha256-5W7GuWZsUjTwjgKnNs7j4wZhOME1Giz757cM3sKuSQY=";
  };

  build-system = [ hatchling ];


  pythonRelaxDeps = [ "pydantic" ];

  dependencies = [
    aiofiles
    aiohttp
    babel
    certifi
    magic-filter
    pydantic
  ];

  nativeCheckInputs = [
    aiohttp-socks
    aresponses
    motor
    pycryptodomex
    pymongo
    pytest-aiohttp
    pytest-asyncio
    pytest-lazy-fixture
    pytestCheckHook
    pytz
    redis
  ];

  pytestFlagsArray = [
    "-W"
    "ignore::pluggy.PluggyTeardownRaisedWarning"
    "-W"
    "ignore::pytest.PytestDeprecationWarning"
    "-W"
    "ignore::DeprecationWarning"
  ];

  pythonImportsCheck = [ "aiogram" ];

  passthru.updateScript = gitUpdater { rev-prefix = "v"; };

  meta = with lib; {
    description = "Modern and fully asynchronous framework for Telegram Bot API";
    homepage = "https://github.com/aiogram/aiogram";
    changelog = "https://github.com/aiogram/aiogram/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ sikmir ];
  };
}
