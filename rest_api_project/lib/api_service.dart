import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rest_api_project/post.dart';

class ApiService {
  static const String apiUrl = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonPosts = json.decode(response.body);
      return jsonPosts.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Error loading posts');
    }
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error creating post');
    }
  }

  Future<void> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$apiUrl/${post.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(post.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error updating post');
    }
  }

  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode != 200) {
      throw Exception('Error deleting post');
    }
  }
}
