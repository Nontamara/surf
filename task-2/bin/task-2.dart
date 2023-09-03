class Phone {
  String modelName;
  String controlInterface;
  int? batteryCapacity;
  DisplayInfo? display;
  List<CameraInfo>? camera;
  int price;
  static const bool canDoCalls = true;

  Phone({
    required this.modelName,
    required this.controlInterface,
    this.batteryCapacity,
    required this.price,
  });

  Phone.printInfo(this.modelName, this.controlInterface, this.price){
    print("\nModel name: $modelName");
    print("Control interface: $controlInterface");
    if (batteryCapacity != null) {
      print("Battery capacity: $batteryCapacity");
    }
    if (modelName == 'nokia3310') {
      DisplayInfo.printInfo(displayDiagonalSize: 2.4, resolutionHeight: 320,
          resolutionWidth: 240, monochromatic: true);
    }
    if (modelName == 'googlePixel') {
      DisplayInfo.printInfo(displayDiagonalSize: 5, resolutionHeight: 1920,
          resolutionWidth: 1080, monochromatic: false);
      CameraInfo.printInfo(resolution: 12.3, maxOpticalZoom: 1, maxDigitalZoom: 4);
    }
    print("Price: $price\$");
  }

  Phone.makeACall(this.modelName, this.controlInterface, this.price){
    if (canDoCalls == true) {
      print("\nCalling someone with $modelName");
    }
    else{
      print("\nSorry, but this device can't be used to make calls. Why is it called a phone in the first place?");
    }
  }
}

class DisplayInfo{
  final double displayDiagonalSize;
  final int resolutionHeight;
  final int resolutionWidth;
  final bool monochromatic;

  DisplayInfo({
    required this.displayDiagonalSize,
    required this.resolutionHeight,
    required this.resolutionWidth,
    required this.monochromatic,
  });

  DisplayInfo.printInfo({required this.displayDiagonalSize, required
  this.resolutionHeight, required this.resolutionWidth,
    required this.monochromatic}){
    print("Display diagonal size: $displayDiagonalSize inches");
    print("Display resolution: $resolutionHeight""x$resolutionWidth px");
    print("Is display monochromatic: $monochromatic");
  }
}

class CameraInfo{
  final double resolution;
  final double maxOpticalZoom;
  double maxDigitalZoom;

  CameraInfo({
    required this.resolution,
    required this.maxOpticalZoom,
    required this.maxDigitalZoom
  });

  CameraInfo.printInfo({required this.resolution, required this.maxOpticalZoom,
    required this.maxDigitalZoom}){
    print("Camera resolution: $resolution MP");
    print("Max optical zoom: $maxOpticalZoom x");
    print("Max digital zoom: $maxDigitalZoom x");
  }
}

void main() {
  Phone.printInfo('panasonicKXTS', 'buttons', 12);
  Phone.printInfo('nokia3310', 'buttons', 16);
  Phone.printInfo('googlePixel', 'touchscreen', 80);
  Phone.makeACall('googlePixel', 'touchscreen', 80);
}
