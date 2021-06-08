class Memory {
  //all the variables that are stored in the memory class
  DateTime memoryCreatedTime;
  String memoryImage;
  String memoryName;
  String memoryDescription;
  String memoryCategory;
  double memoryLat;
  double memoryLong;

  Memory({
    this.memoryCreatedTime,
    this.memoryImage,
    this.memoryName,
    this.memoryDescription,
    this.memoryCategory,
    this.memoryLat,
    this.memoryLong,
  });

  Map toMap() {
    return {
      'memoryCreatedTime': this.memoryCreatedTime != null
          ? this.memoryCreatedTime.toIso8601String()
          : null,
      'memoryImagePath': this.memoryImage,
      'memoryName': this.memoryName,
      'memoryDescription': this.memoryDescription,
      'memoryCategory': this.memoryCategory,
      'memoryLat': this.memoryLat,
      'memoryLong': this.memoryLong,
    };
  }

  Memory.fromMap(Map map)
      : this.memoryCreatedTime = map['memoryCreatedTime'] == null
            ? null
            : DateTime.tryParse(map['memoryCreatedTime']),
        this.memoryImage = map['memoryImagePath'],
        this.memoryName = map['memoryName'],
        this.memoryDescription = map['memoryDescription'],
        this.memoryCategory = map['memoryCategory'],
        this.memoryLat = map['memoryLat'],
        this.memoryLong = map['memoryLong'];
}
