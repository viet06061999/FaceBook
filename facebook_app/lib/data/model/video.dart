class Video {
  String id = '-1';
  String url = '';
  String thumb = '';

  Video.origin();

  Video(this.id, this.url, this.thumb);

  Map toMap() => new Map<String, dynamic>.from({
    "id": this.id,
    "url": this.url,
    "thumb": this.thumb
  });

  static List<Map> toListMap(List<Video> videos) {
    List<Map> maps = [];
    videos.forEach((Video video) {
      Map step = video.toMap();
      maps.add(step);
    });
    return maps;
  }
}
