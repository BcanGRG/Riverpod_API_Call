import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';
import 'package:riverpod_practise/controller/controller.dart';
import 'package:riverpod_practise/view/loading_widget.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var read = ref.read(Controller.controller);
    var watch = ref.watch(Controller.controller);
    return Scaffold(
      appBar: AppBar(
        title: Text("Riverpod"),
        centerTitle: true,
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Padding(
          padding: 20.horizontalP,
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: OutlinedButton(
                        child: Text("Kullanıcılar (${watch.users?.length})"),
                        onPressed: () => read.notSavedButton(),
                      )),
                  Spacer(),
                  Expanded(
                      flex: 8,
                      child: OutlinedButton(
                        child: Text("Kaydedilenler (${watch.saved?.length})"),
                        onPressed: () => read.savedButton(),
                      ))
                ],
              ),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSaved(watch),
                    saved(watch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView notSaved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.users?.length ?? 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: 15.allBR),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.users?[index].avatar ?? ""),
              radius: 20,
            ),
            title: Text(
              "${watch.users?[index].firstName}  ${watch.users?[index].lastName}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "${watch.users?[index].email}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
            trailing: IconButton(
              onPressed: () => watch.addSaved(watch.users![index]),
              icon: Icon(Icons.send_and_archive_outlined),
            ),
          ),
        );
      },
    );
  }

  ListView saved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.saved?.length ?? 1,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 15);
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: 15.allBR),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.saved?[index].avatar ?? ""),
              radius: 20,
            ),
            title: Text(
              "${watch.saved?[index].firstName}  ${watch.saved?[index].lastName}",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              "${watch.saved?[index].email}",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        );
      },
    );
  }
}
