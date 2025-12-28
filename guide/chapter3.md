# Comprehensive Example

The power of the new structure with the **Dendritic Pattern** becomes evident when you consider how simplified many aspects of the configuration and code maintenance have become. Here's the source of a [comprehensive example](/modules) to demonstrate all previous concepts in a real-world usage for you to explore.

The comprehensive example has this structure:

```graphql
├── flake.nix
└── modules
    ├── hosts
    │   ├── 'homeserver [N]'
    │   │   ├── services
    │   │   │   └── syncthing
    │   │   └── users
    │   ├── 'linux-desktop [N]'
    │   │   └── users
    │   └── 'macbook [D]'
    │       └── users
    ├── nix
    │   ├── 'flake-parts []'
    │   └── tools
    │       ├── 'determinate [D]'
    │       ├── 'home-manager [ND]'
    │       ├── 'homebrew [D]'
    │       ├── 'impermanence [NDn]'
    │       └── 'secrets [NDnd]'
    ├── programs
    │   ├── 'browser [nd]'
    │   ├── 'cli-tools [ND]'
    │   ├── 'gnome [N]'
    │   ├── 'office [nd]'
    │   └── 'shell [nd]'
    ├── services
    │   ├── 'iperf [N]'
    │   ├── 'printing [N]'
    │   ├── 'ssh [ND]'
    │   └── 'syncthing [N]'
    ├── system
    │   ├── settings
    │   │   ├── 'bluetooth [N]'
    │   │   ├── 'firmware [N]'
    │   │   ├── 'systemConstants [NDnd]'
    │   │   └── 'systemd-boot [N]'
    │   └── 'system types'
    │       ├── '1 - system-default [NDnd]'
    │       │   ├── darwin
    │       │   ├── homeManager
    │       │   └── nixos
    │       ├── '2 - system-essential [NDnd]'
    │       ├── '3 - system-basic [NDnd]'
    │       ├── '4 - system-cli [NDnd]'
    │       └── '5 - system-desktop [NDnd]'
    └── users
        ├── 'alice [D]'
        ├── 'bob [NDn]'
        ├── 'eve [N]'
        └── 'mallory [N]'
```

Let's have a look at some details:
- The File Naming Conventions - you may have noticed that some directories have brackets. These brackets serve two purposes: 
	1. They indicate that a directory is the name of a feature, not just for organizational purposes. All feature `.nix` files are always located in a directory named after the feature.
	2. In the brackets, the usage contexts of the feature are listed, categorized by letter: (N)ixOS and/or (D)arwin. Small caps indicate usage in the Home-Manager context. Since not every Home-Manager Configuration works on both systems, "n" and "d" refer to usage for Home-Manager on the specific system.
- You'll only find a small, unrealistic number of features, such as for services, system settings, programs, and so on. Additionally modules often simply import other modules and set a few or no attributes for configuration. This is intentional: more features that repeat the same structure wouldn't add any new information to this example.  A wall of attributes would also make it difficult to explore the structural design variations. I leave the possibility of additional features and attributes to your imagination.
- Separation of features into several files is used intensively - E.g. Flake-parts boilerplate of each feature is put in separate files (with name `flake-parts.nix`) in the feature directories, file separation based on system context (`nixos.nix`, `darwin.nix`), and separation for complexity reasons. An extreme example is `homeserver`. The whole directory structure is one feature. You could place the entire feature into a single file, but separating the code into files, even with sub-directories, significantly simplifies code maintenance and becomes essential for a home server (keep in mind that this is just an excerpt). Although the sub-directories themselves are not features, they are organized with similar names, making it easy to locate where the corresponding features are utilized and configured.
- Features are grouped into obvious directories such as `users`, `hosts`, `services`, and `system/settings` for better organization. Keep in mind that this grouping is merely an example and does not affect the functionality of the features. You can also add other directories and create sub-structures for specific categories like `gaming`, `desktop-managers`, and so on.
- To navigate and manipulate features as desired, relative paths are employed. For instance, refer to the example `nix/tools/secrets`.
- The `system/system types` directory contains features for defining the basic environment, which will be used for all hosts and users. It's a best practice to have some kind of `default` feature. In such a feature, you typically set very low-level system defaults and ensure that all widely used Nix tools in your setup (e.g., home-manager, impermanence, homebrew) are configured. I went overboard and created different system types, creating a hierarchy to define first the bare minimum defaults, then essential Nix tools, then CLI settings, and finally desktop settings. This is an example of using inheritance. It's utilized for hosts and users (e.g., `eve` is a home-manager only user!) that use different system types.
- Creating a new host or user just requires only a few lines of code. The modules automatically match and work as intended across all environments. No extra effort is required to select the necessary code from the comprehensive feature library. See usage of the same feature 'bob' in the `linux-desktop` and on the `macbook`.
- Integrating a new Nix library becomes a breeze, as demonstrated in the `nix/tools` examples. Generate the feature, define all necessary parameters, and seamlessly insert it into the default classes. This approach eliminates the need for modifications to an increasingly complex and fragile `flake.nix` and other module files. Our `flake.nix` is automatically generated from our features and primarily consists of input definitions and a single line to import all feature modules.
- Sometimes, special effort is needed for Nix tools that are only compatible with a specific environment, like the `impermanence` tool, which is only available on NixOS. Since it's used in the code of many features and we want to reuse the same code for Darwin, this becomes a problem. Initially, I used a design approach involving conditional `collector aspects`. While this design is clean, it required significant additional effort to implement the conditions. So, I opted for a simpler approach by defining dummy attributes specifically for the Darwin Home-Manager environment.
- All related components are now conveniently located in the feature's directory, such as `programs/gnome`. This feature concept simplifies debugging and maintaining code consistency significantly. Each feature directory contains all the necessary definitions and settings related to that feature.
- Features can be used on both Linux and MacOS, facilitating code sharing. For instance, `basicPackages` is shared between the two platforms. This separation is achieved through separate modules, eliminating the need for intricate conditional logic. The usage remains simple, as importing the feature automatically selects the appropriate code.
- Although this example showcases a sophisticated directory structure, there's no risk of import errors during refactoring. By employing the Dendritic Pattern, we eliminate the need for manual maintenance of numerous scattered `default.nix` files with lengthy relative file paths.
- The directory `nix/flake-parts` contains a special feature. This feature includes the setup of the Flake Parts Framework, which includes tools that will be used for our Dendritic setup. Additionally, it contains a convenience library that allows you to create the flake output for NixOS, Darwin, and Home-Manager configurations. 
 
Now, it's your turn to try it out. Enjoy exploring the Dendritic Pattern! 

If you find this guide helpful, please leave me a star.

---
[<< Previous Chapter](chapter2.md#design-patterns-for-dendritic-aspects) | [Table of Contents](/README.md#contents) | [Next Chapter >>](chapter4.md#acknowledgement-and-additional-information)

Quick access:
- [Basics for usage of the Dendritic Pattern](chapter1.md#basics-for-usage-of-the-dendritic-pattern)
- [Design Patterns for Dendritic Aspects](chapter2.md#design-patterns-for-dendritic-aspects)
- [Comprehensive Example](#comprehensive-example)
- [Acknowledgement and additional information](chapter4.md#acknowledgement-and-additional-information)
