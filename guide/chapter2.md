# Design Patterns for Dendritic Aspects

With the Dendritic Pattern, everything is built out of ***features***, but it doesn't provide guidance on their design. You discover various approaches employed by others in their configurations, and how they approached a specific requirement.

While creating my own features, I noticed that their construction and usage differ, yet certain recurring patterns emerged. In the following chapter, I'll demonstrate the application of the Dendritic Pattern for recurring design scenarios. Since this guide is based on using the Flake Parts `flake.modules`, we'll define the patterns for use of `aspects`.

The abstract design concepts will be explained with examples in code snippets that focus on a specific aspect. These examples demonstrate how each pattern can be **designed and structured**, emphasizing *code structure*. To minimize distractions, the configuration parts for each `aspect` (e.g., how a desktop manager like `gnome` is configured) are kept minimal, merely indicating their location and not complete for real-world usage. The provided examples should just help you understand the structural pattern and effortlessly identify similar use cases within your code. The same applies to the [Comprehensive Example](chapter4.md#comprehensive-example) chapter.

> [!NOTE]
> It's crucial to remember that this collection is not exhaustive. The patterns presented here are not rigid rules that must be followed verbatim; they are suggestions for design decisions.

## ***Simple Aspect***

<ins>**Use Case:**</ins>

We want to implement a feature that can be used in one or multiple configuration contexts, such as NixOS, Darwin, and Home-Manager. In these contexts, the feature is optional and doesn't depend on other features.

---
 
<ins>**Implications on Module Structure:**</ins>

The `simple aspect` defines an `aspect` without relying on other `aspects`. It can encompass multiple modules, each dedicated to a different `class`, ensuring complete independence and allowing for individual usage.

---
 
<ins>**What we need to do:**</ins>

 Create modules for each desired configuration context. For each context, we create a `class` module (e.g., `flake.modules.nixos.<simple aspect>`, `flake.modules.darwin.<simple aspect>`, or `flake.modules.homeManager.<simple aspect>`).

>[!TIP]
> If you want to define multiple `class` modules, you can do so in a single file. This is particularly useful when you need to share partial configurations.
> Depending on the specific use case, you could split the feature module into separate files indicating the context they define. This approach offers the advantage of easier maintenance of different configuration contexts for a feature.

---
 
<ins>**Example:**</ins>

For a `simple aspect` *basicPackages* used for *NixOS, Darwin and Home-Manager users* our feature would look like this:

```nix
{
  flake.modules.nixos.basicPackages =
    { pkgs }:
    {
      environment.systemPackages =
        with pkgs;
        [
          # list of NixOS system packages
        ];
      # necessary configurations
    };

  flake.modules.darwin.basicPackages =
    { pkgs }:
    {
      environment.systemPackages = with pkgs;
      [
		# list of Darwin system packages
      ];
      # necessary configurations
    };

  flake.modules.homeManager.basicPackages =
    { pkgs }:
    {
      programs = 
        {
          # configuration of various programs
        };
    };
}
```

## ***Multi Context Aspect***

<ins>**Use Case:**</ins>

We want to create a feature that will be exclusively used in a specific main context, such as NixOS or Darwin. This feature will also define mandatory configuration for another nested configuration context, like Home-Manager.

---
 
<ins>**Implications on Module Structure:**</ins>

The `multi-context aspect` defines an `aspect` that simultaneously acts on different `classes`. It consists of a main module that will be used later and an additional private auxiliary module. This auxiliary module is intended for internal use only (private module) within the `multi-context aspect` and is not meant for use outside.

---
 
<ins>**What we need to do:**</ins>

Create a main module for the desired context by creating a `class` module for the `multi-context aspect` (e.g., `flake.modules.nixos.<multi-context aspect>` or `flake.modules.darwin.<multi-context aspect>`). Then, create an auxiliary module with the different `class` (e.g., `flake.modules.homeManager.<multi-context aspect>`). Finally, add code (e.g., `home-manager.sharedModules = [ inputs.self.modules.homeManager.<multi-context aspect> ]`) to the main module to include the auxiliary module directly into the configuration of that class. 

> [!NOTE]
> Putting the auxiliary module into its own named module is a design decision. The same could be achieved by creating the module "inline" without naming it. However, there are benefits to using the auxiliary module, which initially starts as a private module but can later be repurposed in code development as a module that can also be used outside.

---
 
<ins>**Example:**</ins>

For the `multi-context aspect` of the `gnome` feature, we define it by setting the system configuration for NixOS (the main module) and defining settings for Home-Manager (the auxiliary module). The feature itself will only be used in the configuration context of NixOS, not Home-Manager:

```nix
{inputs, ...}:
{
  flake.modules.nixos.gnome = {
    home-manager.sharedModules = [
      inputs.self.modules.homeManager.gnome
    ];
    # configuration of gnome on system level
  };

  flake.modules.homeManager.gnome = { # auxiliary module
    # configuration of gnome with the options of home-manager
  };
}
```

## ***Inheritence Aspect***

<ins>**Use Case:**</ins>

We want to modify and/or extend an existing feature.

---
 
<ins>**Implications on Module Structure:**</ins>

The `inheritance aspect` takes over the configuration of one or more `parent aspects` and modifies or expands them.

---
 
<ins>**What we need to do:**</ins>

Create modules for all existing classes (e.g., `flake.modules.nixos.<inheritance aspect>`, `flake.modules.darwin.<inheritance aspect>`, `flake.modules.homeManager.<inheritance aspect>`) of the parent aspect. Import the respective module in each class and add code for changes or extensions (`imports = [ inputs.self.modules.<class>.<parent aspect> ]`).

>[!WARNING]
>When you combine a `multi-context aspect` with an `inheritance aspect`, you must take precautions to prevent importing modules multiple times. For instance, you should avoid adding the same module multiple times to `home-manager.sharedModules`.

---
 
<ins>**Example:**</ins>

Take a look at the `inheritance aspect` for the feature *system-desktop*, which extends the existing `parent aspect` *system-cli* to provide settings for the desktop environment. We'll implement this for the context of NixOS and Darwin, allowing us to use the new *system-desktop* flexibly.

```nix
{inputs, ...}:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli  # parent aspect

      # extensions and modifications to the parent
      mail
      browser      
      kde
      printing      
    ];
  };

  flake.modules.darwin.system-desktop = {
    imports = with inputs.self.modules.darwin; [
      system-cli # parent aspect
      
      # extensions and modifications to the parent
      mail
      browser
    ];
  };
}
```

## ***Collector Aspect***

<ins>**Use Case:**</ins>

We want to introduce a feature that has a configuration based on other features.

---
 
<ins>**Implications on Module Structure:**</ins>

The new `collector aspect` gains additional configuration by merging the configuration for each `contributor feature` it is used with.

> [!TIP]
> The collection is typically done unconditionally. However, for specific use cases, it can be switched using a function like `lib.mkIf` for the contribution. In very complex situations, you could also use separate multiple collector modules, which would provide even more flexibility.

---
 
<ins>**What we need to do:**</ins>

We define our feature for the `collector aspect` as usual and place all settings that are unrelated to `contributor features` in that section.
At this point, we make an exception to the rule that a single feature only contains aspects with the name of that feature. Instead, we add each module part of the `collector aspect` that is specifically related to a `contributor feature` within the feature.

>[!TIP]
>To indicate that a feature contains parts that will be collected, it's useful to split the feature file and place the contribution in a separate file named after the `collector aspect`. Consequently, we'll have multiple `collector aspect` definition files, each corresponding to a feature where it's used.

>[!NOTE]
> The use of this pattern is a design decision. You can often achieve similar results using attributes for the `<flake class>`, as discussed in the next chapter.

---
 
<ins>**Example:**</ins>

Now, we urgently need an example! A suitable one is the encrypted file-sharing service Syncthing. Each host using Syncthing has its own unique ID. To establish connections with other hosts, you need to store all the peer IDs in the configuration of each host. In the past, you would store all these constants in a central file. However, we can now achieve this more elegantly.

The feature for the `collector aspect` *syncthing* is defined in: 
```nix
{ # <- feature "syncthing"
  flake.modules.nixos.syncthing = {
      services.syncthing = {
        enable = true;
      };
    };
}
```
For each host feature using Synching we add the `collector aspect` *syncthing* configuration: 
```nix
{ # <- feature "homeserver"
  flake.modules.nixos.syncthing = {
    services.syncthing.settings.devices = {
      homeserver = {
        id = "VNV2XTI-6VY6KR2-OCASMST-Z35JUEG-VNV2XTI-KJWBOKQ-6VYUKR2-Z35JUEG";
      };
    };
  };
}
```

## ***Constants Aspect***

<ins>**Use Case:**</ins>

 We want to create a feature that provides constant values to other features, regardless of the configuration context.

 ---
 
<ins>**Implications on Module Structure:**</ins>

 The `constants aspect` defines and sets the necessary constants. It is activated by including it once in a specific feature hierarchy, such as a host. The "constant values" are then utilized by modules within this feature hierarchy.

 ---
 
<ins>**What we need to do:**</ins>

 We create a new `constants aspect` to define and set the self-created options.
 We utilize the `generic` class to ensure that the module can be used in various configuration contexts.
 The `constants aspect` must be included in all configuration contexts, usually at a high-level feature, such as "defaults".

>[!TIP]
>You can have only one `constants aspect` in your entire setup, such as for fixed meta constants. For more complex setups, remember that you can leverage the full flexibility of the module system, including the ability to use multiple modules for variants and using inheritance.

>[!NOTE]
>Using the `constants aspect` is a design decision.
>One of the significant advantages of using the Dendritic Pattern is the ability to share values across multiple features at the highest level, specifically within the`<flake class>` level. Previous workarounds, such as `specialArgs`, have become obsolete.
>
>That means you can also share values by defining, e.g. 
>1. a value with a "let ... in" statement (in one file), which is then used for `aspects` of different class types or 
>2. an option directly in the feature module (`<flake class>`) with `options.<optionName>`. This option can be referenced with `inputs.self.<optionName>` inside your code bridging the gap between the internal options of different module classes.

---

<ins>**Example:**</ins>

In our example, we define constants that we intend to use across all our hosts:
```nix
{
  flake.modules.generic.systemConstants =
    { lib, ... }:
    {
      options.systemConstants = lib.mkOption {
        type = lib.types.attrsOf lib.types.unspecified;
        default = { };
      };

      config.systemConstants = {
        adminEmail = "admin@test.org";
      };
    };
}
```
We include the `constants aspect` in all our class types for our standard system `system-essential`, ensuring their availability across the board:
```nix
{
  flake.modules.nixos.system-essential = {
    imports = [ inputs.self.modules.generic.systemConstants ];
  };

  flake.modules.darwin.system-essential = {
    imports = [ inputs.self.modules.generic.systemConstants ];
  };

  flake.modules.homeManager.system-essential = {
    imports = [ inputs.self.modules.generic.systemConstants ];
  };
}
```

Constants can later be utilized just like any other option value of that configuration:
```nix
  flake.modules.nixos.homeserver =
    { config, ... }:
    {
      services.zfs.zed.settings = {
        ZED_EMAIL_ADDR = [ config.systemConstants.adminEmail ];
      };
    };
```

## ***Factory Aspect***

<ins>**Use Case:**</ins>

 We want to develop features that are based on parameters.

 ---
 
<ins>**Implications on Module Structure:**</ins>

 A `factory aspect` is instantiated for multiple features based on the provided parameters. Subsequently, the `instance aspects` can be utilized in the same manner as any other aspects.
 
 ---
 
<ins>**What we need to do:**</ins>

 We define a `factory aspect function` as a template that generates `flake.modules` based on the provided parameters as attributes. Within the `factory aspect function`, multiple `factory aspects` can be defined, such as for different  `<classes>`. The `factory aspect function` is then stored in a library, making it accessible for use in various features.
 
---

<ins>**Example:**</ins>

First, we need to define our library, where we'll store all our `factory aspect functions`:
```nix
{
  options.flake.factory = lib.mkOption {
    type = lib.types.attrsOf lib.types.unspecified;
    default = { };
  };
}
```

Now, we can create our first `factory aspect function` and add it to our library. Let's assume we want to create a template for new `users`:
```nix
{
  config.flake.factory.user = username: isAdmin: {

    darwin."${username}" = {
      users.users."${username}" = {
        name = "${username}";
      };
      system.primaryUser = lib.mkIf isAdmin "${username}";
    };

    nixos."${username}" = {
      users.users."${username}" = {
        name = "${username}";
      };
      extraGroups = lib.optionals isAdmin [ "wheel" ];
    };
  };
}
```

For the feature `bob`, we create the `instance aspects` using the `user factory aspect function` and then customize the feature further.
```nix
{
  flake.modules = lib.mkMerge [
    (self.factory.user "bob" true)
    {
      nixos.bob = {
      # additional customization
      };

      darwin.bob = {
      # additional customization
      };
    }
  ];
}
```

>[!NOTE]
>You must use `lib.mkMerge` instead of `//` to add customization. Otherwise, the attribute sets won't be recursively merged, and the attributes of the set produced by the function will be overwritten. Or just put the customizations like with any other aspect splitting into a second file. This works fine, too.

## Applying and Selecting Aspect Patterns
 
Creating new features and seamlessly integrating them into your existing structure mostly boils down to using the right design pattern(s) from above.
 
This process involves three steps:

1. Clearly define the requirements of the new feature in comparison to existing features.
2. Assess which aspect patterns align with these requirements.
3. Implement the feature following the specified steps.

It's crucial to recognize that a single feature might necessitate the application of multiple aspect patterns simultaneously. If you encounter a pattern that doesn't fully satisfy your requirements, consider modifying your feature specifications to better align with the available patterns.  

>[!NOTE]
>While it's rare, there might be instances where you require a custom solution. In such situations, it's possible that you've likely created a new **Aspect Design Pattern** to cater to your specific requirements. Please don't hesitate to reach out to me if you'd like to contribute this pattern to this collection.

Let's illustrate the development process with an example of a new, more intricate feature we plan to develop.

The requirements for the new feature *bob* are (yes, also users are just `features` like any other!):
- We want *bob* to configure some *desktopEnvironment* settings in the context of system configurations for Linux and MacOS.
- We are using Home-Manager per default in the system configurations.
- We want *bob* to use the following features: *adminTools* and *videoEditing*.
- It should be possible to use *bob* additionally for Home-Manager standalone settings where we cannot define the host settings.

Identifying which **Aspect Design Patterns** apply:
- (A) "in the context of … Linux and MacOS” → ***Simple Aspect***
- (B) "Home-Manager as module in the system configurations” → ***Multi Context Aspect***
- (C) “following features” → ***Inheritance Aspect***
- (D) "additionally for Home-Manager standalone settings” → ***Simple Aspect***

Let’s examine the resulting code (the capital letters in the code indicate the applied patterns of the requirements above):
```nix
{inputs, ...}:
{
  # (A)
  flake.modules.nixos.bob = {

    # (B)
    home-manager.users.bob = {
      imports = [ inputs.self.modules.homeManager.bob ];
    };

    # (A)
    imports = with inputs.self.modules.nixos; [
      desktopEnvironment
      # other NixOS features we will want on system level
    ];

    # other NixOS user settings for bob

  };

  # (A)
  flake.modules.darwin.bob = {

    # (B)
    home-manager.users.bob = {
      imports = [ inputs.self.modules.homeManager.bob ];
    };
    
    # (A)
    imports = with inputs.self.modules.darwin; [
      desktopEnvironment
      # other Nix-Darwin features we will want on system level
    ];

    # other Darwin user settings for bob

  };

  # (B)
  # (D) -> nothing to do, the internal (private) auxiliary module created for (B) will just be used as a public module
  flake.modules.homeManager.bob = {
  
    # (C)
    imports = with inputs.self.modules.homeManager; [
      adminTools
      videoEditing
    ];
    
    # other home-manager user settings
  };
}
```

## Bringing it all together

Creating a NixOS/Darwin-system or Home-Manager configuration from our features is quite straightforward. Even configurations, such as those for users and hosts, are essentially additional features that we build up in the same way as we do for other features.

As you saw in the previous chapter, we explained how we did it for a user. A typical host, such as our *linux-desktop* example, appears as follows:
```nix
  flake.modules.nixos."linux-desktop" = {

    imports = with inputs.self.modules.nixos; [
      system-cli 	# this module sets everything for a cli-only standard system
      syncthing		# we want the feature syncthing
      bob			# system user + home-manager included (multi context)
      alice
    ];

    # addition configuration of all features and additional settings

  };
```

No we just have to put our NixOS host "linux-desktop" `aspect` module into the nixosConfigurations of the flake output, we use this boilerplate:
```nix
flake.nixosConfigurations = inputs.self.lib.mkNixos "x86_64-linux" "linux-desktop";
```

> [!NOTE]
> See chapter [The Flake Parts Framework](chapter1.md#the-flake-parts-framework) for details about the self defined function we use here.

That’s all! The NixOS configuration can be used!

---
[<< Previous Chapter](chapter1.md#basics-for-usage-of-the-dendritic-pattern) | [Table of Contents](/README.md#contents) | [Next Chapter >>](chapter3.md#comprehensive-example)

Quick access:
- [Basics for usage of the Dendritic Pattern](chapter1.md#basics-for-usage-of-the-dendritic-pattern)
- [Design Patterns for Dendritic Aspects](#design-patterns-for-dendritic-aspects)
- [Comprehensive Example](chapter3.md#comprehensive-example)
- [Acknowledgement and additional information](chapter4.md#acknowledgement-and-additional-information)
