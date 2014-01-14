---
layout: docs
title: 项目布局
prev_section: coding-style
next_section: app-design-rules
permalink: /docs/project-layout/
---

## 概览

大多数Django的项目布局都是互不相同的。出现这种情况的原因是，一方面，Django默认的项目布局不被大家普遍接受：它过分强调简单性，使得对较大规模的Django项目的维护变得困难；另一方面，因为默认的项目布局没有成为标准，究竟什么样的项目布局更好成了仁者见仁智者见智的事情，大家都有了各自的最佳实践。当然，无论各自的最佳实践究竟是什么，都可以从默认的布局入手，分析可以改进的部分，得到符合自己需要的布局。

## Django 1.5的默认布局

建立一个Django 1.5的项目就可以看到它的默认布局：

{% highlight bash %}
$ workon django
$ django-admin.py startproject mysite
$ cd mysite
$ tree .
{% endhighlight %}

<div class="note">
  <h5><code>workon django</code>激活了一个<code>virtualenv</code></h5>
  <p>
    更多关于<code>virtualenv</code>的话题见<a href="#">这里</a>。
  </p>
</div>

命令 `tree .` 的输出如下：

{% highlight bash %}
.
|____manage.py
|____mysite
| |______init__.py
| |____settings.py
| |____urls.py
| |____wsgi.py
{% endhighlight %}

如果再创建一个自定义的app之后，会增加一些文件：

{% highlight bash %}
$ django-admin.py startapp my_app
$ tree .
.
|____manage.py
|____my_app
| |______init__.py
| |____models.py
| |____tests.py
| |____views.py
|____mysite
| |______init__.py
| |____settings.py
| |____urls.py
| |____wsgi.py
{% endhighlight %}

## 改进一:管理依赖

首先，在根目录放置一个 `requirements.txt` 文件，然后创建一个 `requirments` 目录来放对应各种场景的具体依赖：

{% highlight bash %}
$ touch requirements.txt
$ mkdir requirements
$ touch requirements/{base.txt,local.txt,production.txt,test.txt}
$ tree .
.
|____manage.py
|____my_app
| |______init__.py
| |____models.py
| |____tests.py
| |____views.py
|____mysite
| |______init__.py
| |____settings.py
| |____urls.py
| |____wsgi.py
|____requirement.txt
| |____requirements
| | |____base.txt
| | |____local.txt
| | |____production.txt
| | |____test.txt
{% endhighlight %}

顶层的 `requirements.txt` 只是引用具体的某个文件：通常是 `production.txt`。 `base.txt` 里面放一些公共的依赖，比如Django。 `local.txt` 和 `production.txt` 分别放本地开发的依赖和实际部署的依赖。 `test.txt` 放测试所需的依赖。这样分割有显而易见的好处：如果你在开发环境里使用的是sqlite，那么就不需要安装部署环境中跟mysql有关的依赖了。除此之外，分割依赖到多个文件中还可以:

<ul>
<li>避免安装所有依赖花掉大量的时间</li>
<li>避免安装所有依赖面临的问题。比如你在用来部署的<code>CentOS</code> 上安装 <code>libxml2</code> 或者 <code>libpq-dev</code> 可能并不是那么困难。但是在你本地，比如 <code>Mac OS X</code> 上安装可能就会遇到这样那样的问题</li>
</ul>

<div class="note">
  <h5>为什么在顶层目录要放一个仅仅是引用其他文件的<code>requirements.txt</code>？</h5>
  <p>
    这是因为在流行的部署环境如Heroku等要求项目的根目录必须有一个 `requirements.txt` 文件。
  </p>
</div>

## 改进二：优化Applications和Libraries的布局

Django项目的组成单位是 `apps` 。有一些 `app` 没有 `model` , `views` 而是简单的提供功能的函数或者manangement命令或者是自定义的 `templatetags` ， 这些 `app` 被称为 `helpers` 或者 `libraries` 。

优化项目的布局，主要是通过把 `app` 放到 `apps`下面，把 `library` 放到 `libraries` 下面，结合 [前面](/docs/coding-style/) 提到的相对路径导入：

{% highlight bash %}
...
| | | |____apps
| | | | |______init__.py
| | | |____libs
| | | | |______init__.py
...
{% endhighlight %}

这样布局的好处在于：

- 可以方便的找到并重用你自己写的一个 `app`
- 可以方便的找到并重用你自己写的一个 `library`

## 改进三：优化Settings

关于项目布局的最佳实践争论最多的地方就是Django的 `settings` 模块。我们抛弃了系统自动生成的 `settings.py` ，参考依赖的管理方式，生成了各个场景对应的配置文件：

{% highlight bash %}
...
| | | |____settings
| | | | |______init__.py
| | | | |____base.py
| | | | |____local.py
| | | | |____production.py
| | | | |____test.py
...
{% endhighlight %}

这样布局主要是考虑：
<ul>
<li>如何根据不同场景划分settings（开发、部署、测试)</li>
<li>如何把所有的配置都放到版本控制里面跟踪起来</li>
<li>如何保护密码等信息来提高安全性</li>
<li>如何让改动settings变得方便快捷</li>
</ul>

## 改进四：资源文件

项目的资源文件放在static文件夹下，目前默认包括了 `bootstrap` 相关文件：

{% highlight bash %}
...
| | |____static
| | | |____css
| | | | |____bootstrap-responsive.min.css
| | | | |____bootstrap.min.css
| | | | |____project.css
| | | |____img
| | | | |____glyphicons-halflings-white.png
| | | | |____glyphicons-halflings.png
| | | |____js
| | | | |____bootstrap.min.js
| | | | |____project.js
...
{% endhighlight %}

目前项目放在 [django-zoomteam-template](http://gitlab.zoomteam.cn/django-zoomteam-template) ，使用这个模板的具体方法可以看该项目的说明。
