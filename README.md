# CDLabel

适用于聊天气泡中的label.一种简单的富文本label，包括图片 链接 文字'

特点：异步渲染，以达到流畅效果



CDLabel: 展示文本控件

CTDataConfig：

CTData：

CDCalculator.share: 单例对象，负责计算和渲染CDLabel的展示内容

CDCalculator: 每个CDLabel拥有一个CDCalculator，负责调用CDCalculator.share计算和渲染，CDCalculator.share完成后，通知CDLabel展示
 

