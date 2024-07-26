+++
title = 'Test_shortcode'
date = 2024-07-26T11:08:50+08:00
draft = false
series = ["Hello"]
series_order = 2

+++

## Alert

{{< alert icon="fire" cardColor="#e63946" iconColor="#1d3557" textColor="#f1faee" >}}
This is an error!
{{< /alert >}}

## Article link

{{< article link="/posts/helloworld/" >}}

## Button

{{< button href="https://baidu.com" target="_self" >}}
Click to jump to Baidu.com

{{< /button >}}

## Chart

{{< chart >}}
type: 'line',
data: {
  labels: ['Tomato', 'Blueberry', 'Banana', 'Lime', 'Orange'],
  datasets: [{
    label: '# of votes',
    data: [12, 19, 3, 5, 3],
  }]
}
{{< /chart >}}

{{< chart >}}
type: 'bar',
data: {
  labels: ['Tomato', 'Blueberry', 'Banana', 'Lime', 'Orange'],
  datasets: [{
    label: '# of votes',
    data: [12, 19, 3, 5, 3],
  }]
}
{{< /chart >}}

## Github Card

{{< github repo="sitaye/Hugo" >}}

## Katex

{{< katex >}}
\\(f(a,b,c) = (a^2+b^2+c^2)^3\\)
$$
E=mc^2
$$

## Lead 强调

{{< lead >}}
When life gives you lemons, make lemonade.
{{< /lead >}}

## 时间线

{{< timeline >}}

{{< timelineItem icon="github" header="header" badge="badge test" subheader="subheader" >}}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus non magna ex. Donec sollicitudin ut lorem quis lobortis. Nam ac ipsum libero. Sed a ex eget ipsum tincidunt venenatis quis sed nisl. Pellentesque sed urna vel odio consequat tincidunt id ut purus. Nam sollicitudin est sed dui interdum rhoncus. 
{{< /timelineItem >}}

{{< timelineItem icon="code" header="Another Awesome Header" badge="date - present" subheader="Awesome Subheader" >}}
With html code

<ul>
  <li>Coffee</li>
  <li>Tea</li>
  <li>Milk</li>
</ul>
{{< /timelineItem >}}

{{< timelineItem icon="star" header="Shortcodes" badge="AWESOME" >}}
With other shortcodes
{{< /timelineItem >}}

{{< timelineItem icon="code" header="Another Awesome Header">}}

{{< /timelineItem >}}

{{< /timeline >}}

## 打字机效果

{{< typeit 
  tag=h3
  speed=50
  breakLines=false
  loop=true >}}
Lorem ipsum dolor sit amet, 
consectetur adipiscing elit. 
{{< /typeit >}}
