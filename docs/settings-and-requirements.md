---
layout: docs
title: 配置文件
prev_section: app-design-rules
next_section: home
permalink: /docs/settings-and-requirements/
---

这里所谓的配置文件主要指settings文件和requirements文件。

Django 1.5有超过130项可以通过 `settings` 文件进行配置的选项。由于是在服务器启动的时候加载配置，所以大多数针对settings的修改需要在服务器重启后才能生效。一些相关的最佳实践是：

- **所有的配置文件都应该版本控制** ：特别是在production环境下使用的配置文件更是如此。
- **DRY** ： `Don't repeat yourself` ，也就是尽量把公共的配置项放到一个基础的配置文件里面，而不要在不同环境的配置文件里面拷来拷去。

## 避免使用不在代码库里面的本地配置

本地的开发环境不可避免的有些跟生产环境不同的配置，比如数据库连接，SECRET_KEY等等。

<div class="note warning">
  <h5>Warning:保护好你的秘密</h5>
  <br/>
  <p>在Django里面，`SECRET_KEY` 被用来进行加密签名，因此最好是不要放在代码库里面。使用一个对别人来说已知的 `SECRET_KEY` ，会使得很多Django提供的安全机制失效，造成严重的安全隐患。更多的详情，可以参考：<a href="https://docs.djangoproject.com/en/1.5/topics/signing">官方文档</a> </p>
  <br/>
  <p>基于同样的理由，诸如数据库密码、AWS key、OAuth的token等信息，最好都不要放在代码仓库里面。</p>
</div>

保存本地配置过去通行的做法就是创建一个 `local_settings.py` 文件。这个文件是针对具体机器创建的（可以是开发机也可以是产品机），并且故意没有放到代码库里面。这样做可能带来的问题有：

* 每个机器都有一些没有被版本控制的代码
* 因为有没有加入版本控制的代码，就意味着部署有手工流程，经常会发生配置文件拷错的情况
* 同时，没有版本控制意味着每个开发人员都要手动同步这堆配置文件

更先进的做法是，为不同的环境编写不同的配置文件，同时仍然能保障具体环境的秘密仍然是秘密。

## 使用多个配置文件

<div class="note">
  <h5>ProTips™ 灵感来源于"The One True Way"</h5>
  <br/>
  <p>这种配置方式由Jacob Kaplan-Moss提出，并在OSCON 2011上以<a href="http://www.slideshare.net/jacobian/thebest-and-worst-of-django">'The Best and Worst of Django'</a>为题目的演讲中被提到。</p>
</div>

和Django标准教程中使用单个settings.py不同，这种配置方式是创建一个settings/文件夹，然后在这个文件夹下面放置下面的这些配置文件：

{% highlight bash %}
settings/
    __init__.py
    base.py
    local.py
    staging.py
    test.py
    production.py
{% endhighlight %}

<div class="note warning">
  <h5>Warning:Requirements + Settings</h5>
  <br/>
  <p>每个settings文件对应一个环境，所以一般也有对应的requirements文件。</p>
</div>


<div class="mobile-side-scroller">
<table>
  <thead>
    <tr>
      <th>Settings 文件</th>
      <th>用途</th>
    </tr>
  </thead>
  <tbody>
    <tr class='setting'>
      <td class="align-center">
        <p>base.py</p>
      </td>
      <td>
        <p class='description'>通用的配置</p>
      </td>
    </tr>
    <tr class='setting'>
      <td class="align-center">
        <p>local.py</p>
      </td>
      <td>
        <p class='description'>本地开发使用的配置。一般来说这种配置下 `DEBUG` 模式是打开的，又更多的日志，`django-debug-toolbar` 这类辅助app也是启用的</p>
      </td>
    </tr>
    <tr class='setting'>
      <td class="align-center">
        <p>staging.py</p>
      </td>
      <td>
        <p class='description'>Staging环境用来在部署生产环境之前给QA或者PO甚至是用户进行体验。同时有些团队也把Staging用来进行产品环境上出现的bug的调试</p>
      </td>
    </tr>
    <tr class='setting'>
      <td class="align-center">
        <p>test.py</p>
      </td>
      <td>
        <p class='description'>所有和测试有关的配置，比如test runner，内存数据库定义，log配置等</p>
      </td>
    </tr>
    <tr class='setting'>
      <td class="align-center">
        <p>production.py</p>
      </td>
      <td>
        <p class='description'>顾名思义用来放置生产环境的配置文件，有些时候被命名成prod.py</p>
      </td>
    </tr>
  </tbody>
</table>
</div>

