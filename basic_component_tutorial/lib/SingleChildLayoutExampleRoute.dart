import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// 实现一个单子组件 CustomCenter，功能基本和 Center 组件对齐
class CustomCenter extends SingleChildRenderObjectWidget {
  const CustomCenter({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCustomCenter();
  }
}

// Abstract class for one-child-layout render boxes that provide control over
// the child's position.
// 可以指定子组件的位置
/// 这里直接继承 RenderObject 会更接近底层一点，但这需要我们自己手动实现一些和布局无关的东西，比如事件分发等逻辑。
/// 为了更聚焦布局本身，我们选择继承自RenderShiftedBox，它会帮我们实现布局之外的一些功能，
/// 这样我们只需要重写performLayout，在该函数中实现子节点居中算法即可。
class RenderCustomCenter extends RenderShiftedBox {
  RenderCustomCenter({RenderBox? child}) : super(child);

  @override
  void performLayout() {
    super.performLayout();
    // 1. 先对子组件进行layout，随后获取它的size
    child!.layout(constraints.loosen(), // 将约束传递给子节点
        parentUsesSize: true // 接下来要使用child的size,所以不能为false
        );
    // 2.根据子组件的大小确定自身的大小
    size = constraints.constrain(Size(
        constraints.maxWidth == double.infinity
            ? child!.size.width
            : double.infinity,
        constraints.maxHeight == double.infinity
            ? child!.size.height
            : double.infinity));
    // 3. 根据父节点子节点的大小，算出子节点在父节点中居中之后的偏移，然后将这个偏移保存在
    //    子节点的parentData中，在后续的绘制阶段，会用到。
    BoxParentData parentData = child!.parentData as BoxParentData;
    parentData.offset = ((size - child!.size) as Offset) / 2;
  }
}

/// 实现一个 LeftRightBox 组件来实现左-右布局，因为LeftRightBox 有两个孩子，用一个 Widget 数组来保存子组件。
class LeftRightBox extends MultiChildRenderObjectWidget {
  LeftRightBox({Key? key, required List<Widget> children})
      : assert(children.length == 2, "只能传两个children"),
        super(key: key, children: children);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLeftRight();
  }
}

class LeftRightParentData extends ContainerBoxParentData<RenderBox> {}

// ContainerRenderObjectMixin 和 RenderBoxContainerDefaultsMixin 两个 mixin，
// 这两个 mixin 实现了通用的绘制和事件处理相关逻辑
class RenderLeftRight extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, LeftRightParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, LeftRightParentData> {

  // 初始化每一个child的parentData
  @override
  void setupParentData(covariant RenderObject child) {
    super.setupParentData(child);

    if (child.parentData is! LeftRightParentData) {
      child.parentData = LeftRightParentData();
    }
  }

  @override
  void performLayout() {
    super.performLayout();

    final BoxConstraints constraints = this.constraints;
    RenderBox leftChild = firstChild!;

    LeftRightParentData childParentData = leftChild.parentData! as LeftRightParentData;

    RenderBox rightChild = childParentData.nextSibling!;
    //我们限制右孩子宽度不超过总宽度一半
    rightChild.layout(
      constraints.copyWith(maxWidth: constraints.maxWidth / 2),
      parentUsesSize: true,
    );
    //调整右子节点的offset
    childParentData = rightChild.parentData! as LeftRightParentData;
    childParentData.offset = Offset(
      constraints.maxWidth - rightChild.size.width,
      0,
    );

    // layout left child
    // 左子节点的offset默认为（0，0），为了确保左子节点始终能显示，我们不修改它的offset
    leftChild.layout(
      //左侧剩余的最大宽度
      constraints.copyWith(
        maxWidth: constraints.maxWidth - rightChild.size.width,
      ),
      parentUsesSize: true,
    );

    //设置LeftRight自身的size
    size = Size(
      constraints.maxWidth,
      max(leftChild.size.height, rightChild.size.height),
    );

  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

}
