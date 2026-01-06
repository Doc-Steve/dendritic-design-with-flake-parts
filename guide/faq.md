## Frequently Asked Questions - Dendritic Pattern

- [Frequently Asked Questions - Dendritic Pattern](#frequently-asked-questions---dendritic-pattern)
	- [What is it? Why should I care?](#what-is-it-why-should-i-care)
	- [What are the advantages?](#what-are-the-advantages)
	- [Why is the definition of the Dendritic Pattern so complicated? What if I don't understand everything?](#why-is-the-definition-of-the-dendritic-pattern-so-complicated-what-if-i-dont-understand-everything)
	- [Is Flake-Parts the Dendritic Pattern? Why use two names?](#is-flake-parts-the-dendritic-pattern-why-use-two-names)
	- [Should I start  my config design with the Dendritic Pattern? Is a migration worth it?](#should-i-start--my-config-design-with-the-dendritic-pattern-is-a-migration-worth-it)
	- [Is it only useful for cross-platform development, or is there more to it?](#is-it-only-useful-for-cross-platform-development-or-is-there-more-to-it)
	- [Dendritic Pattern seems just like a "buzzword", why is this different from what I'm already doing for the configuration of my hosts?](#dendritic-pattern-seems-just-like-a-buzzword-why-is-this-different-from-what-im-already-doing-for-the-configuration-of-my-hosts)
	- [How does it compare to other template repositories / host management tools?](#how-does-it-compare-to-other-template-repositories--host-management-tools)
	- [I already use modules, why should I put an abstraction layer on top?](#i-already-use-modules-why-should-i-put-an-abstraction-layer-on-top)
	- [Should I use Flake-Parts and what are the alternatives?](#should-i-use-flake-parts-and-what-are-the-alternatives)
	- [Is it mandatory for me to learn all the `Aspect` patterns mentioned in the guide?](#is-it-mandatory-for-me-to-learn-all-the-aspect-patterns-mentioned-in-the-guide)

---

### What is it? Why should I care?

<h3 align="center"> Dendritic Pattern is a <ins>software design pattern</ins>.</h3>

**Quote from [Wikipedia](https://en.wikipedia.org/wiki/Software_design_pattern)** 
>A software design pattern describes a reusable solution to a commonly needed behavior in software. A design pattern is not a rigid structure to be copied directly into source code. Rather, it is a description of and a template for solving a particular type of problem that can be used in many different contexts, including different programming languages and computing platforms. Design patterns can be viewed as formalized best practices that the programmer may use to solve common problems when designing software.

In essence, it defines a _way of doing_ things. It is not a NIX library nor a framework.

The pattern contains two main principles:
- Top-level modules: everything is constructed from top-level modules, which define lower-level modules.
- Features: code is bundled into features, which serve as the building blocks for structuring the code.

It's perfectly acceptable if you don't grasp the meaning of this immediately. A more detailed explanation is necessary (refer to the [guide](/README.md#contents) ). However, once you comprehend these two principles, the application of the pattern in your code becomes effortless. It's simply that you approach things differently now.

The Dendritic Pattern's strength lies in its use of very simple and generic rules that yield several significant benefits when adhered to. These benefits are implicit and naturally arise from using the pattern; you don't have to take any additional actions. Utilizing the pattern simplifies many design challenges that you may have encountered before.

While you may need to invest time initially (for learning new concepts and refactoring your existing code), the long-term benefits will, in most cases, outweigh the effort.

### What are the advantages?

When you design your code based on the Dendritic Pattern, you'll enjoy several key advantages, in no particular order:

- **Multi-platform Support:**
	- Code for multiple platforms is grouped together and coexists within a single file.
	- All platforms share the same code structure, making it easier to develop for different platforms.
	- Using code for different platforms becomes magically effortless, you just use the feature.
- **Simplified Structural Design:**
	- Everything is a self-contained building block, a feature. This coherent system for structuring your code based on these building blocks simplifies the design process.
	- The Dendritic Pattern helps you create a clean and simple code structure, addressing the question "Where to place this configuration?".
- **Reduced Dependencies:**
	- Adding or removing things is equivalent to adding or removing features.
	- This minimal dependency structure makes code management easier.
- **Decreased Effort:**
	- The amount of glue code is reduced, and you have to create fewer options. Enabling is often replaced by imports, making the code more concise.
- **Enhanced Reusability:**
	- Features consolidate everything in one place, simplifying code reuse in other projects.
	- Standardization allows for easier code exchange, and files become self-documenting for those familiar with the conventions.
- **Improved Bug Fixing:**
	- The Dendritic Pattern enforces consolidation, eliminating the search in scattered code pieces that may broke.
- **Freedom of File (Re-)Organization:**
	- Changing file names or paths doesn't break the code.
	- Automatic importing eliminates the need for complex relative input paths in `default.nix` files.
- **Integrated Communication Between Configuration Classes:**
	- Workaround constructs like `specialArgs` become unnecessary.
	- You can bridge the gap between different configuration classes naturally with `let ... in`or higher level options.
- **Consistent Semantic Meaning:**
	- Every `.nix` file has the same module type and belongs to a feature. This eliminates file type confusion between NixOS module files and Home-Manager module files.
- **Decluttered `flake.nix`:**
	- The primary task of `flake.nix` is reduced to defining inputs.
	- Relevant code blocks are now in their appropriate locations, not in a overly complex `flake.nix`. 

It may seem like an exaggeration to claim that two simple design principles will have such a significant impact, but you'll likely experience awe-inspiring moments yourself when you begin working with the pattern.

Of course, Dendritic Design isn't the sole method for designing your code. Other patterns and solutions for single problems exist. Therefore, you may have already achieved a subset (or all) of the advantages mentioned above in your existing setup using your own solutions. The Dendritic Pattern stands out because it is simple yet incredibly powerful.

If you like to look into more (technical) details about the advantages, you can use this [Dendritic Nix Summary by Vic](https://vic.github.io/dendrix/Dendritic.html).

### Why is the definition of the Dendritic Pattern so complicated? What if I don't understand everything?

The Dendritic Pattern is intentionally very generic. It defines a design pattern on a very abstract level, making it independent of the tools / frameworks used and the specific area of application (e.g., flake, non-flake).

This universal nature comes with a trade-off: you need to use very precise language and specialized terms that are only understandable by experts. It's similar to reading a legal text: it's written in your mother tongue, but you may not understand anything at all or even worse, you may misunderstand it. You need law training (like a lawyer) to read such texts, or you need a how-to translation for specific cases made for non-experts.

The positive news is that you don't have to understand all the abstract details of the Dendritic Pattern, such as the [`deferredModule` type](https://nixos.org/manual/nixos/stable/#sec-option-types-submodule), if you just want to "drive the car" instead of "engineering it".

If you start using the Dendritic Pattern with Flake-Parts, you need minimal background knowledge. Of course, tools like Flake-Parts can do so much more cool things that you couldn't do without, but this will be an optional feature. You don't have to cover that from the start; use the introduction in the guide first.

### Is Flake-Parts the Dendritic Pattern? Why use two names? 

The pattern itself is generic and doesn't depend on a specific tool or framework.

Flake-Parts is a framework that can be used to easily implement the design principles of the Dendritic Pattern for flakes. The confusion between Flake-Parts and the Dendritic Pattern arises because Flake-Parts is widely used in repositories based on the Dendritic Pattern, and many examples explain it using this framework.

### Should I start  my config design with the Dendritic Pattern? Is a migration worth it?

To answer these questions, it's best to consider different scenarios.

1. If you're a complete beginner and just started with Nix, you should take your first steps without following a pattern. Patterns address problems you won't encounter at the beginning of your journey. However, if you gain more experience and encounter issues with a more complex setup, you should reevaluate your approach.
2. If you're an experienced user and starting a new configuration from scratch, there are very few arguments against using the Dendritic Design from the start. However, you can also use a specific configuration tool that you're **very confident** will meet your needs and skip the Dendritic Design.
3. If you're an experienced user with a complex and unstable setup, you've likely navigated yourself through many redesigns to a point where code changes become increasingly time-consuming, and structural changes would require a redesign anyway. In this situation, the Dendritic Pattern is a no-brainer. In most cases, it will be the silver bullet you've been searching for.
4. If you're a very experienced user with a complex and stable setup, you may have already addressed many of the advantages of the Dendritic Design with your elaborate setup. This is especially true if you're an intensive user of flake-parts and have other design principles like "roles" in place. Going "all-in" and converting everything to top-level modules and features may be worth the effort to consistently reap the benefits. However, this is a trade-off. If you're happy with your current setup, there's nothing wrong with sticking with it. Keep the Dendritic Design in your drawer for a rainy day when you can test it out and see if it can solve your problem.
### Is it only useful for cross-platform development, or is there more to it?

The Dendritic Design offers numerous advantages when implemented. The impact of these benefits can vary depending on the specific use case.

It excels in multi-platform environments, particularly when combining two or more of NixOS, Nix-Darwin, Home-Manager for systems, or Home-Manager standalone. This is often the point where complexity increases significantly, making the current code base difficult to manage, debug, or extend.

However, the Dendritic Design can also be beneficial in other use cases, such as gaming setups and desktop ricing. While it may not provide specific advantages for configuring these areas, it helps modularize code for better combination, reuse, and exchange with others working on the same configuration. For example, the Dendrix community-driven distribution of Dendritic Nix configurations, available on this site from @vic [Dendrix - community-driven distribution of Dendritic Nix configurations.](https://dendrix.oeiuwq.com/), offers a collection of shared Dendritic code and more information on this topic.

Many of the benefits of the Dendritic Design are use-case independent. For instance, it leads to a clutter-free flake.nix file, simplifies file (re-)organization, and enhances code modularity. These advantages might be enough to consider adopting the Dendritic Design pattern, particularly when starting a configuration from scratch.

### Dendritic Pattern seems just like a "buzzword", why is this different from what I'm already doing for the configuration of my hosts?

If you merely glance at the headlines and spot words like "modules" and "features", it might initially appear that Dendritic is merely a buzzword for something trivial, something you're already doing.

However, this couldn't be further from the truth:
- The term "feature" carries a specific meaning, which is likely quite different from your interpretation. In this context, "feature" refers to a novel design concept. If the term had been chosen differently, such as "Dendritic Pattern Building Block," you might not have drawn incorrect conclusions. However, "feature" is undeniably more catchy. Just remember that it's more than just a word.
- Using "top-level" modules for everything is not the standard approach of simply placing modules in separate files. While you may already be using modules for everything, you may not have the additional abstraction level in your modules that is essential for the Dendritic Pattern.

### How does it compare to other template repositories / host management tools?

The Dendritic Pattern is not a template or a code toolset. It offers a "how-to" for your design, but not more, not less.

This "how-to" is quite simple to use, yet incredibly powerful. It renders many template repositories and host management tools obsolete because you can now effortlessly create similar things yourself, which you may not have been able to design before. Of course, practice is necessary, but the basics are straightforward, and the complexity of your setup can grow with your experience without necessitating a redesign!

### I already use modules, why should I put an abstraction layer on top?

Using top-level modules is a key factor in the advantages of the Dendritic Pattern. Initially, the concept may appear artificial, but it presents numerous possibilities that were previously unavailable. Once you comprehend the concept, there's no additional coding effort required when utilizing this technique; you simply reap the benefits.

### Should I use Flake-Parts and what are the alternatives?

At the moment, Flake-Parts is probably the most widely used tool or framework for generating a Dendritic setup. Especially as a beginner, it's a safe choice. Most examples and reference repositories are based on it. It has a large user base; a current search on GitHub showed over 14,000 `flakes.nix` files using it as an import.

If you're looking for a non-flake toolset, you should definitely check out [vic/dendritic-unflake](https://github.com/vic/dendritic-unflake).

There are also tools available that offer a Dendritic Design with additional helper functions and concepts to simplify your workflow. These tools often use flake-parts under the hood. 

Some examples:
- [den - an aspect-oriented approach to Dendritic Nix configurations](https://github.com/vic/den)
- [Unify - A framework for unifying multiple types of Nix configurations, allowing you to easily define them in the same modules](https://codeberg.org/quasigod/unify/)

### Is it mandatory for me to learn all the `Aspect` patterns mentioned in the guide?

The `Aspect` patterns provided in the guide are meant to inspire you and serve as a template for similar situations.

Of course, they are not mandatory in any way to utilize the Dendritic Pattern.
