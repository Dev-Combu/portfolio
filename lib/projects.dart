class Project {
  final String title;
  final String description;
  final String stack;
  final String link;
  final String? homepage; // new field for app homepage URL

  Project({
    required this.title,
    required this.description,
    required this.stack,
    required this.link,
    this.homepage,
  });
}

List<Project> projects = [
  Project(
    title: 'Aina',
    description: '이 프로젝트는 Flutter를 사용하여 개발된 앱입니다. ai를 활용한 일기 앱입니다..',
    stack: 'Flutter, Dart',
    link: 'https://github.com/Dev-Combu/Aina',
    homepage: 'https://aina.dev',
  ),
  Project(
    title: 'Oz_player',
    description: 'Flutter로 개발된 음악 플레이어 앱입니다. ai를 이용해서 사용자의 현재 상태에 맞춤 추천을 제공하고, 사용자 친화적인 인터페이스를 제공합니다.',
    stack: 'Flutter, Dart',
    link: 'https://github.com/Oz-player/oz_player',
    homepage: 'https://ozplayer.dev',
  ),
  Project(
    title: 'EGO',
    description: 'Swift로 개발된 앱입니다. 일기를 쓰면서 캐릭터를 키우는 앱입니다.',
    stack: 'Swift',
    link: 'https://github.com/EGO-project/EGO',
  ),
  Project(
    title: 'Do_dream_youth',
    description: 'flutter를 이용한 성당 학생 출석 어플리케이션입니다.',
    stack: 'Flutter, Dart',
    link: 'https://github.com/Dev-Combu/Do_dream_youth',
    homepage: 'https://dev-combu.github.io/DoDream.github.io/',
  ),
];
