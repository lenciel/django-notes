---
layout: docs
title: 编码规范
next_section: project-layout
prev_section: home
permalink: /docs/coding-style/
---

Python的 [The Zen of Python (PEP 20)﻿](http://www.python.org/dev/peps/pep-0020/) 是Python编码的最佳实践的浓缩。在编写Django项目的代码时，我们要求：

- 尽量合理地遵守 [Style Guide for Python Code(PEP8)](http://www.python.org/dev/peps/pep-0008/) 
- 遵守 [Django coding style](https://docs.djangoproject.com/en/dev/internals/contributing/writing-code/coding-style/) 

## PEP8

PEP8作为Python官方的编程规范，对命名、缩进、注释等各个方面都有详细的规定。代码提交review之前，所有的文件都应该符合PEP8要求(如果你记不住那些规则，找一个你使用的IDE的插件来检验)。每次代码提交之后，我们的Jenkins上也有PEP8的检查。如果不幸(不幸是指，违反PEP8的文件都不应该上传到代码库)发现了PEP8的violation，要及时去查看并处理。

如果你加入的项目本来就没有遵循PEP8规范，那么就按照项目现有的风格来完成你的开发。你可以在PEP8的 [A Foolish Consistency is the Hobgoblin of Little Minds](http://www.python.org/dev/peps/pep-0008/#id8) 查看这样做的原因以及其他可以不遵循PEP8的万不得已的情况。

## Imports的管理

PEP8建议 `import` 应该按照下面的顺序来排列:

{% highlight python %}
1. 标准库
2. 项目相关第三方库
3. 本地应用或者库
{% endhighlight %}

在Django项目中，我们使用的导入顺序一般如下例所示：

{% highlight python %}
例子 1.1

# 标准库
from math import sqrt 
from os.path import abspath 
 
# Django核心库
from django.db import models 
from django.utils.translation \ 
    import ugettext_lazy as _ 
 
# 第三方应用 
from django_extensions.db.models \ 
    import TimeStampedModel 
 
# local应用 
from splits.models import BananaSplit
{% endhighlight %}

<div class="note info">
  <p>实际的开发中imports不需要像例子1.1那样注释，这里只是为了更清楚地说明。</p>
</div>

所以我们的 `import` 顺序为:

{% highlight python %}
1. 标准库
2. Django的核心库
3. 项目相关的第三方库
4. Local的application或者library
{% endhighlight %}

## 使用显式声明的相对路径导入

Python里面使用显式声明的相对路径导入来对各个module进行解耦。我们先看一个使用硬编码路径而不是相对路径导入的例子：

{% highlight python %}
例子 1.2

# report/views.py 
from django.views.generic \ 
    import CreateView 
 
# 硬编码的导入方式
from report.models import Report 
from report.forms import ReportForm 
from report.views import ReportPage 
 
class WaffleConeCreateView(ReportPage, 
                        CreateView): 
    model = Report 
    form_class = ReportForm

{% endhighlight %}

虽然在当前项目里面这样的导入是没有问题的但是会严重降低模块的移植性和重用性：

- 如果你需要在其他项目里面使用这个 `report` app，但是那个项目里面已经有一个叫 `report` 的包了呢？
- 如果你突然发现用户要的是图表而不是表格，所以这个app的名字要从 `report` 要改成 `chart` 呢？

如果是硬编码的导入，出现上面的需求时，你就得到每个文件里面去把这些导入都改一遍。下面我们看看如何使用显式的相对路径导入：

{% highlight python %}
例子 1.3

# report/views.py 
from django.views.generic \ 
    import CreateView 
 
# Relative imports of the 
#   ’report’ package 
from .models import Report 
from .forms import ReportForm 
from core.views import ReportPage

class WaffleConeCreateView(ReportPage, 
                        CreateView): 
    model = Report 
    form_class = ReportForm
{% endhighlight %}

下面总结一下Python里面不同的导入方式和它们在Django项目中使用的方式：


<div class="mobile-side-scroller">
<table>
  <thead>
    <tr>
      <th>Code</th>
      <th>导入方式</th>
      <th>用途</th>
    </tr>
  </thead>
  <tbody>
    <tr class='setting'>
      <td>
        <p class='description'>
          from core.views import FoodMixin
        </p>
      </td>
      <td class="align-center">
        <p>绝对路径导入</p>
      </td>
      <td>
        <p class='description'>从当前app之外导入</p>
      </td>
    </tr>
    <tr class='setting'>
      <td>
        <p class='description'>
          from .models import WaffleCone
        </p>
      </td>
      <td class="align-center">
        <p>显式声明的相对路径</p>
      </td>
      <td>
        <p class='description'>推荐用来从当前app的另一个module中导入</p>
      </td>
    </tr>
    <tr class='setting'>
      <td>
        <p class='description'>
          from cones.models import WaffleCone
        </p>
      </td>
      <td class="align-center">
        <p>隐式声明的相对路径</p>
      </td>
      <td>
        <p class='description'>常被用来从当前app的另一个module中导入，不推荐</p>
      </td>
    </tr>
  </tbody>
</table>
</div>

<div class="note">
  <h5>ProTips™ PEP 328和PEP 8难道不是矛盾的么？</h5>
  <p>Guido Van Rossum <a href="http://mail.python.org/pipermail/python-dev/2010-October/104476.html">这样说</a></p>
  <p>更多信息见 <a href="http://www.python.org/dev/peps/pep-0328/">这里</a></p>
</div>
