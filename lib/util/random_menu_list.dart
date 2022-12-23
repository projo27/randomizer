class MenuImage {
  String routeName;
  String title;
  String description;
  String imageAsset;
  bool proOnly;
  bool onDevelop;

  MenuImage({
    required this.routeName,
    required this.title,
    required this.description,
    required this.imageAsset,
    this.proOnly = false,
    this.onDevelop = false,
  });
}

List<MenuImage> randomMenuImages = [
  MenuImage(
    routeName: '/flip_coin',
    imageAsset: 'assets/images/flip_coin.jpg',
    title: 'Flip Coin',
    description: 'Flip Coin and get your fortune ;)',
  ),
  MenuImage(
    routeName: '/dice',
    imageAsset: 'assets/images/dice.jpg',
    title: 'Roll the Dice',
    description: 'Just Roll the dice with 1 - 6 number you could get',
  ),
  MenuImage(
    routeName: '/number',
    imageAsset: 'assets/images/number.jpg',
    title: 'Number',
    description: 'Get Random Number between two Number, or a List of Number',
  ),
  MenuImage(
    routeName: '/list_of_text',
    imageAsset: 'assets/images/list_of_text.jpg',
    title: 'List Of Text',
    description:
        'Get random of Text from Lists Of Text, \nYou could choose Name over Group of People, \nor Just choose Random Food on the Menu Restaurant',
  ),
  MenuImage(
    routeName: '/date',
    imageAsset: 'assets/images/date.jpg',
    title: 'Date',
    description:
        'Want to plan the task or event or journey? but cannot decide? use this date boxing',
  ),
  MenuImage(
    routeName: '/create_team',
    imageAsset: 'assets/images/create_team.jpg',
    title: 'Create Team',
    description:
        'Want to play and build a team from some of people? \nAnd you know level of every person? \nand want to balance every team?',
  ),
  MenuImage(
    routeName: '/list_of_url',
    imageAsset: 'assets/images/list_of_text.jpg',
    // imageAsset: 'assets/images/list_of_url.jpg',
    title: 'List Of URL',
    description:
        'Suck or too lazy for browsing something? \nDon\'t know again what do you want to access website? it will random the URL you own',
  ),
  MenuImage(
    routeName: '/country',
    imageAsset: 'assets/images/country.jpg',
    title: 'Country',
    description:
        'Starting new journey by visiting another country in the world but too complex to decide? use this',
  ),
  MenuImage(
    routeName: '/password',
    imageAsset: 'assets/images/password.jpg',
    title: 'Password Generator',
    description:
        'Simple tool to generate password. Maybe you wanna save in this application? OK',
  ),
  MenuImage(
    routeName: '/phone_contact',
    imageAsset: 'assets/images/contact.jpg',
    title: 'Contact',
    description: 'Just random contacting person on your contact book',
    onDevelop: true,
  ),
  MenuImage(
    routeName: '/photo_album',
    imageAsset: 'assets/images/photo_album.jpg',
    title: 'Photo Album',
    description:
        'Too much of Photo on your phone? want to remember the moment? but don\'t know where to start? just random your photo album',
    onDevelop: true,
  ),
  MenuImage(
    routeName: '/music',
    // imageAsset: 'assets/images/music.jpg',
    imageAsset: 'assets/images/list_of_text.jpg',
    title: 'Music',
    description: 'Get and Listen a random of your music from your phone',
    onDevelop: true,
  ),
  MenuImage(
    routeName: '/google_sheet',
    imageAsset: 'assets/images/google_sheet.jpg',
    title: 'Google Sheet',
    description:
        'Have many rows on your google sheet? and want to decide something important but get more problem? use this',
    proOnly: true,
    onDevelop: true,
  ),
  MenuImage(
    routeName: '/news',
    imageAsset: 'assets/images/news.jpg',
    title: 'News',
    description: 'Just Get Random News',
    proOnly: true,
    onDevelop: true,
  ),
  MenuImage(
    routeName: '/rest_api',
    imageAsset: 'assets/images/rest_api.jpg',
    title: 'Rest API',
    description:
        'Have and API and want to get random from the list of your API? use this',
    proOnly: true,
    onDevelop: true,
  ),
];
