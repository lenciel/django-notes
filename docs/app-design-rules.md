---
layout: docs
title: App设计准则
prev_section: project-layout
next_section: how-to-contribute
permalink: /docs/app-design-rules/
---

初学Django常见的一个问题就是什么是"app"。

- 一个 *Django project* 是指使用Django框架开发的一个完整的web应用。
- 一个 *Django app* 是指Django project下的一个具体的模块。每个Django project都有多个app，其中一部分app是内部使用的，其他的是可以被别的project重用的。
- 一个 *Third-party Django package* 是指第三方开发的即插即用的Django app。所谓即插即用通常是指该app使用了Python的打包工具打包，可以直接通过pip安装和使用。

## Django App设计的基本准则

James Bennett，Django的release manager和core developer说过：


>“The art of a creating and maintaining a good Django app is that it should follow
the truncated Unix philosophy according to Douglas McIlroy:
>‘Write programs that do one thing and do it well.’”

也就是说，每个app应该聚焦并完成一个特定的功能点。如果一个app的作用不能用一句话说明白，可能它就需要被拆分成更小的app。

## Django App的命名准则

由于前面的基本准则的设计思想，推荐简单的app命名使用单个单词：一般来说就是这个模块的model的复数即可。很多时候，由于app是一个完整的功能模块，包含的model可能很多，这个时候反而用单数来命名app表示它是一个集合比较合适，比如一个叫blog的app。

另外，注意命名的时候不仅需要考虑model的名字，还需要考虑url的pattern。如果你希望你的博客访问地址是http://www.example.com/weblog，那么对应的app就应该叫weblog而不是blog或者posts，即使这个app的主要的model就是POST。这样做可以让你在维护项目的时候很方便地确定哪个app对应哪个入口。

app的命名如果超过一个单词，就要注意符合[PEP-8规范](http://www.python.org/dev/peps/pep-0008/)，因为app其实说白了就是一个Python的package，它的命名应该都使用小写字母，单词之间用下划线隔开，不能使用数字、空格、斜杠等特殊符号。

## 让App变小

在项目开始阶段不需要纠结于追求完美的app设计：it's an art, not science。很多时候你都会在项目过程中重命名或者打散app，这很正常。你只需要有一个基本的思路：让app变小。一个由很多app组成的project通常是好设计的表现，相反如果一个app非常的臃肿，那多半是设计上出现了问题。