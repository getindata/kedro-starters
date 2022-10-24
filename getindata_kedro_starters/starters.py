from pathlib import Path

from kedro.framework.cli.starters import KedroStarterSpec

base_dir = Path(__file__).resolve().parent

starters = [
    KedroStarterSpec(
        alias=starter.name,
        template_path=str(base_dir),
        directory=starter.name,
    )
    for starter in base_dir.glob("*")
    if starter.is_dir() and starter.name != "__pycache__"
]
