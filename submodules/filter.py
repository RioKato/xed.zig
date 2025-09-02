def main():
    from argparse import ArgumentParser
    from pathlib import Path
    import json
    import sys

    parser = ArgumentParser()
    parser.add_argument("compile_commands")
    parser.add_argument("objlist")
    args = parser.parse_args()

    objlist = []

    with open(args.objlist) as fp:
        for name in fp:
            name = name.strip()
            objlist.append(name)

    with open(args.compile_commands) as fp:
        ccj = json.load(fp)

    filtered = []

    for unit in ccj:
        output = Path(unit["output"])

        if output.name in objlist:
            filtered.append(unit)

    json.dump(filtered, sys.stdout, indent=2)


if __name__ == "__main__":
    main()
