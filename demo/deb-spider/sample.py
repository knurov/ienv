#!/usr/bin/python
"""Example for packages. Print all essential and important packages"""

import apt_pkg
from apt import package


def check_version(pkgver):
    """Check the version of the package"""
    missing = []

    for or_group in pkgver.depends_list.get("Pre-Depends", []) + \
                    pkgver.depends_list.get("Depends", []):
        if not any(dep.all_targets() for dep in or_group):
            # If none of the or-choices can be satisfied, add it to missing
            missing.append(or_group)

    if missing:
        print("Package:", pkgver.parent_pkg.name)
        print("Version:", pkgver.ver_str)
        print("Missing:")
        print(", ".join(" | ".join(fmt_dep(dep) for dep in or_group))
                        for or_group in missing)
        print()

def main():
    """Main."""
    apt_pkg.init_config()
    apt_pkg.init_system()
    cache = apt_pkg.Cache()
    print("Essential packages:")
    # for pkg in cache.packages:
    #     if pkg.essential:
    #         print(" ", pkg.name)
    print("Important packages:")
    for pkg in cache.packages:
        if pkg.important:
            print(" ", pkg.name)
            for version in pkg.version_list:
                # Check every version
                for pfile, _ in version.file_list:

                    print("Package:", version.parent_pkg.name)
                    print("Version:", version.ver_str)
                    print("Pfile:", pfile)

                    package.Version

                    # if (pfile.origin == "Debian"
                    #     and pfile.component == "main"
                    #     and pfile.archive == "unstable") :
                    #     # We only want packages from Debian unstable main.
                    #     check_version(version)
                    #     break



if __name__ == "__main__":
    main()