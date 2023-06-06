import 'package:lottie/lottie.dart';

Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Lottie.network(
                'https://assets7.lottiefiles.com/packages/lf20_pvpf4883.json',
                repeat: true,
                reverse: true,
                animate: true,
              ),
            ),
          ),
