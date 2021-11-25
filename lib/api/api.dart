import 'package:http/http.dart' as http;

class API {
  Future<http.Response> fetchSubscriptions() async {
    final headers = {
      'Authorization':
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhMzY3MDU0Zi0xNmQxLTQ2YTctYjIwNC01NjE3ODdhZjE0NDEiLCJpYXQiOjE2MzcyMjE2MTYsImV4cCI6MTYzOTgxMzYxNiwiaXNzIjoiYWRtaW5AdGF1Z2h0Iiwic3ViIjoic3ViQHRhdWdodCJ9.DZUaj3YDn4v1Dm3HciiDxFfBYkhhlm4vsmHciT3f7WpwLlXhLvQuZiP1ruSAVsM2IDeKB6Kqgr4Cf4zn37F-rcK0FF1vuE5NH-2iXMc9hEQ-O1tYl6L82KScNPt57FVc-spz1LyR5AyFXzUG-N72IrogRcS4WJ4X0oITrp6GIRcc7QBjUbN-_3tzh8zet08hGaIiU8hrdvDc75LmlYCF9Hv2KJPH521V-uTZosI6jwW6HrnQ9ePrOvNiCvNqSnQNZgxCJTfAaaI5eTs14bsun6ebQjfrwNHsd-lh3adtGv8JQZ8uvnS086hs9pvsfW4L1Kctl4I51UBOfrTGy6TKm3Z08C7cVdjboUslA-YtpN8XGyPi7v1iPw4FcDxAvAsCRyE2smAhay22GDXtM5m_WcvFeUMWmaruXzv4NhJLXr0xODb1-IGF1FX2LiaURWqO7roMTH0JVcdQW1bQznBpXQ0m6oLyg4Ln3UuLhtYR9ZQ1_cezdkIBSLl3sJnwalpt'
    };

    final response = await http.get(
      Uri.parse(
        'https://staging-azure.taught.academy/slotting/subscription/fetchSubscribedSessions/a367054f-16d1-46a7-b204-561787af1441',
      ),
      headers: headers,
    );

    return response;
  }

  Future<http.Response> fetchProfiles() async {
    final headers = {
      'Authorization':
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJhMzY3MDU0Zi0xNmQxLTQ2YTctYjIwNC01NjE3ODdhZjE0NDEiLCJpYXQiOjE2MzcyMjE2MTYsImV4cCI6MTYzOTgxMzYxNiwiaXNzIjoiYWRtaW5AdGF1Z2h0Iiwic3ViIjoic3ViQHRhdWdodCJ9.DZUaj3YDn4v1Dm3HciiDxFfBYkhhlm4vsmHciT3f7WpwLlXhLvQuZiP1ruSAVsM2IDeKB6Kqgr4Cf4zn37F-rcK0FF1vuE5NH-2iXMc9hEQ-O1tYl6L82KScNPt57FVc-spz1LyR5AyFXzUG-N72IrogRcS4WJ4X0oITrp6GIRcc7QBjUbN-_3tzh8zet08hGaIiU8hrdvDc75LmlYCF9Hv2KJPH521V-uTZosI6jwW6HrnQ9ePrOvNiCvNqSnQNZgxCJTfAaaI5eTs14bsun6ebQjfrwNHsd-lh3adtGv8JQZ8uvnS086hs9pvsfW4L1Kctl4I51UBOfrTGy6TKm3Z08C7cVdjboUslA-YtpN8XGyPi7v1iPw4FcDxAvAsCRyE2smAhay22GDXtM5m_WcvFeUMWmaruXzv4NhJLXr0xODb1-IGF1FX2LiaURWqO7roMTH0JVcdQW1bQznBpXQ0m6oLyg4Ln3UuLhtYR9ZQ1_cezdkIBSLl3sJnwalpt'
    };

    final response = await http.get(
      Uri.parse(
        'https://staging-azure.taught.academy/user/profiles?userId=a367054f-16d1-46a7-b204-561787af1441',
      ),
      headers: headers,
    );

    return response;
  }
}
