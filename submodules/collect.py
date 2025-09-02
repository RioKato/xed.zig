from pathlib import Path
import json
import shutil

HOME = Path(__file__).parent


def homepath(base: Path | str, root: Path) -> Path:
    assert root.is_absolute()
    return (root / base).relative_to(HOME)


def parse(command: list[str]) -> tuple[list[str], list[str]]:
    incdirs = []
    others = []

    for option in command:
        if not option.startswith("-"):
            continue

        if option in ["-c", "-o"]:
            continue

        if option.startswith("-I"):
            incdirs.append(option[2:])
            continue

        others.append(option)

    return incdirs, others


def copy(ccj: any, out: Path):
    for unit in ccj:
        directory = Path(unit["directory"])

        src = homepath(unit["file"], directory)
        src, dst = HOME / src, out / src
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy(src, dst)

        for incdir in parse(unit["arguments"])[0]:
            src = homepath(incdir, directory)
            src, dst = HOME / src, out / src
            dst.mkdir(parents=True, exist_ok=True)

            for incfile in src.iterdir():
                if incfile.suffix == ".h":
                    shutil.copy(incfile, dst / incfile.name)


def recipe(ccj: any) -> any:
    includes = set()
    units = []

    for unit in ccj:
        directory = Path(unit["directory"])

        file = homepath(unit["file"], directory)
        incdir, flags = parse(unit["arguments"])
        incdir = [homepath(i, directory) for i in incdir]
        includes.update(incdir)

        unit = dict(
            file=str(file),
            flags=flags,
        )

        units.append(unit)

    return dict(
        units=units,
        includes=[str(i) for i in includes],
    )


def main():
    from argparse import ArgumentParser

    parser = ArgumentParser()
    parser.add_argument("compile_commands")
    parser.add_argument("output")
    args = parser.parse_args()

    with open(args.compile_commands) as fp:
        ccj = json.load(fp)

    out = Path(args.output)
    copy(ccj, out)

    with open(out / "recipe.json", "w") as fp:
        json.dump(recipe(ccj), fp, indent=2)


if __name__ == "__main__":
    main()
