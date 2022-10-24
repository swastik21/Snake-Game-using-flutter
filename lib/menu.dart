import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snake_game/game.dart';
import 'package:snake_game/services/route_service.dart';
import 'package:snake_game/services/user_service.dart';

import 'model/user.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RouteService>(
      builder: (context, value, child) {
        if (value.navigateTo == 2) {
          return game(value);
        } else {
          return menu(value);
        }
      },
    );
  }

  Widget menu(RouteService routeService) {
    final userService = Provider.of<UserService>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<User>(
        future: userService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            User user = snapshot.data!;
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            "Highscore: ${user.highScore}",
                            style: const TextStyle(
                                fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/img/logo2.png',
                          width: 500,
                          height: 500,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: _button(
                              "Start",
                              () => routeService.navigate(2),
                              Colors.amber,
                              const Icon(Icons.play_arrow)),
                        ),
                      )
                    ]),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _button(String text, Function() onTap, Color color, Icon icon) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton.icon(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: onTap,
        icon: icon,
        label: Text(
          text,
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }

  Widget game(RouteService routeService) {
    final userService = Provider.of<UserService>(context, listen: false);
    return FutureBuilder(
      future: userService.getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          User user = snapshot.data!;
          return Game(user);
        }
        return Container();
      },
    );
  }
}
