import 'package:flutter/material.dart';
class ImageViewerScreen extends StatefulWidget {
  final String image ;
  final int id;
  const ImageViewerScreen({Key key ,  this.image , this.id}) : super(key: key);

  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState();
}

class _ImageViewerScreenState extends State<ImageViewerScreen> with SingleTickerProviderStateMixin{

  final _transformationController = TransformationController();
  TapDownDetails _doubleTapDetails ;
  AnimationController _animationController ;
  Animation<Matrix4> _animation ;
  String image ;


  @override
  void initState() {
    super.initState();
    image = widget.image;
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    )..addListener(() {
      _transformationController.value = _animation.value;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
          onDoubleTapDown: _handleDoubleTapDown,
          onDoubleTap: _handleDoubleTap,
          child: Center(
          child: InteractiveViewer(
            transformationController: _transformationController,
            ///enable the image to move when it is in the normal size
            // boundaryMargin: EdgeInsets.all(10),
            panEnabled: true,
            scaleEnabled: true,
            minScale: 1.0 ,
            maxScale: 2.5 ,
            child: Hero(
              /// widget.id like super in inheritance
              tag: "${widget.id}",
              child: Image.network(image,
              fit: BoxFit.fitWidth,
          ),
            ),
        ))
      ),
    );
  }

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    Matrix4 _endMatrix;
    Offset _position = _doubleTapDetails.localPosition;

    if (_transformationController.value != Matrix4.identity()) {
      _endMatrix = Matrix4.identity();
    }
    else {
      _endMatrix = Matrix4.identity()
        ..translate(-_position.dx , -_position.dy )
        ..scale(2.0);
    }

    _animation = Matrix4Tween(
      begin: _transformationController.value,
      end: _endMatrix,
    ).animate(
      CurveTween(curve: Curves.easeOut).animate(_animationController),
    );
    _animationController.forward(from: 0);
  }

}
