import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hw/bloc/anthentication_bloc.dart';
import 'package:hw/model/book.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

class ByAuthorPage extends StatefulWidget {
  const ByAuthorPage({super.key});

  @override
  State<ByAuthorPage> createState() => _ByAuthorPageState();
}

class _ByAuthorPageState extends State<ByAuthorPage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    // Fill books with sample data
    books = [
      Book(title: '1984', author: 'George Orwell', detail: 'Detail 1'),
      Book(title: 'Beloved', author: 'Toni Morrison', detail: 'Detail 2'),
      Book(title: 'Anna Karenina', author: 'Leo Tolstoy', detail: 'Detail 3'),
      Book(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', detail: 'Detail 4'),
      Book(title: 'Emma',author: 'Jane Austen', detail: 'Detail 5'),
    ];
    books.sort((a, b) => a.author.compareTo(b.author));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('By Author'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () {
              // Navigate to detail page
              context.go('/byAuthor/detail', extra: book);
            },
          );
        },
      ),
    );
  }
}

class ByTitlePage extends StatefulWidget {
  const ByTitlePage({super.key});

  @override
  State<ByTitlePage> createState() => _ByTitlePageState();
}

class _ByTitlePageState extends State<ByTitlePage> {
  List<Book> books = [];

  @override
  void initState() {
    super.initState();
    // Fill books with sample data
    books = [
      Book(title: '1984', author: 'George Orwell', detail: 'Detail 1'),
      Book(title: 'Beloved', author: 'Toni Morrison', detail: 'Detail 2'),
      Book(title: 'Anna Karenina', author: 'Leo Tolstoy', detail: 'Detail 3'),
      Book(title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', detail: 'Detail 4'),
      Book(title: 'Emma',author: 'Jane Austen', detail: 'Detail 5'),
    ];
    books.sort((a, b) => a.title.compareTo(b.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('By Title'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text(book.author),
            onTap: () {
              // Navigate to detail page
              context.go('/byTitle/detail', extra: book);
            },
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the logOut method from AuthenticationBloc
            context.read<AuthenticationBloc>().logOut();
            // Navigate to the login page
            context.go('/login');
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Call the logIn method from AuthenticationBloc
            context.read<AuthenticationBloc>().logIn();
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
class ByAuthorDetailPage extends StatelessWidget {
  final Book book;

  const ByAuthorDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${book.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Author: ${book.author}\nDetail: ${book.detail}'),
      ),
    );
  }
}

class ByTitleDetailPage extends StatelessWidget {
  final Book book;

  const ByTitleDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail: ${book.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('Author: ${book.author}\nDetail: ${book.detail}'),
      ),
    );
  }
}