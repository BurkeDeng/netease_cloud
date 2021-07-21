import 'dart:async';

import 'package:flutter/material.dart';

//TODO:全局浮窗
class FloatingWindow {
  static OverlayEntry _holder;

  static Widget view;
  Stream<Offset> offSetStream;
  StreamSink<Offset> offSetSink;
  StreamController<Offset> onDragEndOffsetStreamController;

  FloatingWindow() {
    onDragEndOffsetStreamController = StreamController<Offset>.broadcast();
    offSetSink = onDragEndOffsetStreamController.sink;
    offSetStream = onDragEndOffsetStreamController.stream;
  }

  void remove() {
    if (_holder != null) {
      _holder.remove();
      _holder = null;
    }
  }

  void show({@required BuildContext context, @required Widget view}) {
    FloatingWindow.view = view;

    remove();
    //创建一个OverlayEntry对象
    OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
      return new Positioned(
        top: MediaQuery.of(context).size.height * 0.2,
        right: 0,
        child: _buildDraggable(context),
      );
    });

    //往Overlay中插入插入OverlayEntry
    Overlay.of(context).insert(overlayEntry);

    _holder = overlayEntry;
  }

  _buildDraggable(context) {
    return Draggable(
      child: view,
      feedback: view,
      onDragStarted: () {
        print('onDragStarted:');
      },
      onDragEnd: (detail) {
        print('onDragEnd:${detail.offset}');
        offSetSink.add(detail.offset);
        onDragEndOffsetStreamController.sink.add(detail.offset);
        createDragTarget(offset: detail.offset, context: context);
      },
      childWhenDragging: Container(),
    );
  }

  static void refresh() {
    _holder.markNeedsBuild();
  }

  void createDragTarget({Offset offset, BuildContext context}) {
    if (_holder != null) {
      _holder.remove();
    }

    _holder = new OverlayEntry(builder: (context) {
      bool isLeft = true;
      if (offset.dx + 100 > MediaQuery.of(context).size.width / 2) {
        isLeft = false;
      }

      double maxY = MediaQuery.of(context).size.height - 100;

      return new Positioned(
          top: offset.dy < 50
              ? 50
              : offset.dy < maxY
                  ? offset.dy
                  : maxY,
          left: isLeft ? 0 : null,
          right: isLeft ? null : 0,
          child: DragTarget(
            onWillAccept: (data) {
              print('onWillAccept: $data');
              return true;
            },
            onAccept: (data) {
              print('onAccept: $data');
              // refresh();
            },
            onLeave: (data) {
              print('onLeave');
            },
            builder: (BuildContext context, List incoming, List rejected) {
              return _buildDraggable(context);
            },
          ));
    });
    Overlay.of(context).insert(_holder);
  }
}
