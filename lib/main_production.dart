import 'package:bitecube/app/app.dart';
import 'package:bitecube/app/view/router.dart';
import 'package:bitecube/bootstrap.dart';

void main() {
  bootstrap(() => App(
        appRouter: AppRouter(),
      ));
}
