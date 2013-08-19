---
layout: docs
title: 如何贡献内容
prev_section: project-layout
permalink: /docs/how-to-contribute/
---

你有自己的最佳实践想要分享或者是修订现有的内容？Great! 下面是一些你可能用得上的信息。

Dependencies
-------------

要编译和查看这个Jekyll生成的站点，你需要安装Jekyll所需的依赖:

{% highlight bash %}
~ $ gem install jekyll
{% endhighlight %}

一个比较详细的Jekyll安装过程可以参考 [这里](http://lenciel.github.io/blog/2013/03/10/blog-with-octopress-and-github-pages/)。

Workflow
--------

目前这个项目放在Github上，我们协作的最直接的方式当然是用Github的fork模式:

* Fork本项目
* Clone你自己的fork:

{% highlight bash %}
git clone git://github.com/<username>/django-notes.git
{% endhighlight %}

* 创建一个 `topic branch` 来放你的修改:

{% highlight bash %}
git checkout -b my_awesome_feature
{% endhighlight %}

* 修改后确保一切正常:

{% highlight bash %}
~/django-notes $ cd site
~/django-notes/site $ jekyll serve --watch
# => 查看 http://localhost:4000
{% endhighlight %}

<div class="note">
  <h5>ProTips™  <code>--watch</code>参数</h5>
  <p>使用watch参数，jekyll项目会被自动build和部署，刷新浏览器即可查看修改后的效果。</p>
</div>

* 如果需要， `rebase` 你的 `commit` 。
* `push` 这个 `branch` :

{% highlight bash %}
git push origin my_awesome_feature
{% endhighlight %}

* 创建一个 `pull request` 并简单描述你添加的部分。

<div class="note info">
  <h5>提醒我们缺失或错误的部分!</h5>
  <p>
    如果你只是想提建议而不是直接编写文档，或者你发现的问题不是你编写的部分，可以提交一个 <a
    href="https://github.com/mojombo/jekyll/issues/new">issue</a> 给我们。
  </p>
</div>

项目结构
--------

Jekyll其实主要就是个文本转换的引擎。你把用你自己熟悉的markup语言(不管是Markdown还是Textile等)或者是HTML编写的页面交给它，它通过layout文件等配置文件定义的样子生成最终的静态网页。

我们的项目的site文件夹主要的结构如下:

{% highlight bash %}
.
├── _config.yml
├── _includes
|   ├── footer.html
|   └── header.html
|   └── ...
├── _layouts
|   ├── default.html
|   └── docs.html
├── _site
├── css
├── img
├── js
└── index.html
{% endhighlight %}

它们的用途简单归纳如下:

<div class="mobile-side-scroller">
<table>
  <thead>
    <tr>
      <th>File / Directory</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        <p><code>_config.yml</code></p>
      </td>
      <td>
        <p>
          保存全局配置。注意，如果你在本地调试的时候，需要把<code>url</code>这条配置注释掉。
        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>_includes</code></p>
      </td>
      <td>
        <p>
          可重用的页面或者部分页面。
        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>_layouts</code></p>
      </td>
      <td>
        <p>

          页面的模板。在 `_includes` 中定义的内容可以在模板中被使用，
          <code>{% raw %}{{ content }}{% endraw %}</code>
          可以用来规定页面内容被插入到哪里。

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>_site</code></p>
      </td>
      <td>
        <p>

          Jekyll编译后生成的内容，一般加到 <code>.gitignore</code> 中。

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p><code>index.html</code> 和其他HTML, Markdown, Textile文件</p>
      </td>
      <td>
        <p>

          任何在site根目录的<code>.html</code>、<code>.markdown</code>、
          <code>.md</code>或者 <code>.textile</code>文件都会被Jekyll转换。

        </p>
      </td>
    </tr>
    <tr>
      <td>
        <p>其他文件和目录</p>
      </td>
      <td>
        <p>

          任何site根目录下的其他目录或者文件如<code>css</code>、<code>images</code>、<code>js</code>目录或者<code>favicon.png</code>文件, 会被直接拷贝到 `_site` 目录下。

        </p>
      </td>
    </tr>
  </tbody>
</table>
</div>
