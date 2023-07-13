import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:iconly/iconly.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:suitmedia_intern/response.dart';
import 'package:suitmedia_intern/second_screen.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, required this.name});

  final String name;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final _numberOfUsersPerRequest = 10;

  final PagingController<int, User> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await get(Uri.parse(
          "https://reqres.in/api/users?page=$pageKey&per_page=$_numberOfUsersPerRequest"));
      // print(response.body);
      ResponseUser responseUser =
          ResponseUser.fromJson(json.decode(response.body));
      // print(responseUser.data);
      List<User> userList =
          responseUser.data.map((data) => User.fromJson(data)).toList();
      final isLastPage = userList.length < _numberOfUsersPerRequest;
      if (isLastPage) {
        _pagingController.appendLastPage(userList);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(userList, nextPageKey);
      }
    } catch (e) {
      print("error ->> $e");
      setState(() {
        _pagingController.error = e;
      });
    }
  }

  Widget itemUser(User user) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondScreen(
                    name: widget.name,
                    username: "${user.firstName} ${user.lastName}"),
              ),
            );
          },
          leading: SizedBox(
            width: 50,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.avatarUrl),
            ),
          ),
          title: Text(
            "${user.firstName} ${user.lastName}",
            style: GoogleFonts.poppins().copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            user.email,
            style: GoogleFonts.poppins().copyWith(
              color: const Color(0xFF686777),
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Third Screen",
          style: GoogleFonts.poppins().copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            IconlyLight.arrow_left_2,
            color: Color(0xFF554AF0),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(() => _pagingController.refresh()),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PagedListView<int, User>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<User>(
              itemBuilder: (
                context,
                item,
                index,
              ) =>
                  itemUser(item),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
