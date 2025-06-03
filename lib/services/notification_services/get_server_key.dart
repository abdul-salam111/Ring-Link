import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;

class GetServerKey {
  Future<String> getServerToken() async {
    List<String> scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging'
    ];

    final client = await auth.clientViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(
          {
            "type": "service_account",
            "project_id": "ringlink-v1-mvp",
            "private_key_id": "3126d566655c44fd1cdc4bb81f2b057fbcfdd2e3",
            "private_key":
                "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDuiwKCCgMQOhcC\nqyPjvHfQfVv6msywIRtK35ruge8Vr4Obj2NAsm1D/G24Y8S/OeQITt7jj/J4ydS8\nYfy0TRxx58tHZl1BIqm+WRzBARzFXe/etvULenXKNfYyAqBqFi8utzqPIMbWaQz8\nR3+W4YZKIS8t6LYdliv9xbM/ZCDDXF7oxKqQ7AUJt6TIxW53jeU0GpdEeYNr/row\nC5fna5AKa2TCMETNnUEwnt8tD09fxPW3TFOicfIpn+QD0XYWSw653E4OPI5aE3yF\nuZy/1pqqK28Yq2jms6WkHbPxfdT9gKP4OkiOiwxPpyRsj5z8dWYu3FP/z+5lYu4A\n3WZShlkJAgMBAAECggEAH52Q8Yc+LLJmRlZEZXSfNKTIwgguRNG+ekf0ktPpyif+\n+2kfsH11eeNE74FZnDaiAG/jnql/a37kkSszgPoPYRFlocrxZSag9Ld+1h29oHL4\nzb3V8HWEkw5f2PT8KdNS4ZArVLj1YYl+zRj00hyF3eFUDXOgX399yR6gyTAOH5Ym\n/qp3ft93tQ8Xqs1jzqjTlfXnWsOxK08f99d0o0WxWYRM84Bf/GOiwT0HILCvDFvR\nDBpXITLZG9BKuYS9628k1g1XMZ/0kgoIvkdpfIRQvlYe0YMdkNIPcp2vHw3LGuUc\nSINdO8lSrdLivzdpgV4Hhlz30DUzlpQuTFhlEUJWmQKBgQD97IrbGD0MhvZYsKlG\n5vBx9H2qC8zQJwrh046Io/zk8YHh9Y547m0NtLhEqDlSaFsxtKXwEfeX3V8yeTy5\nzAAIafsyCqaqsYN4lZcfkGD5Vh+pByW27BGY0Obn9/5oZXG+ZbJ4noFGgZTcGzcW\nUn+VDsNqMnAY+6O1ehINeRe0NwKBgQDwfkZ6nAW4qEecyyewnI/xx/gEfDH6U/mV\njDE93ieAvST5G9DKfloi9BjQdldDYCI5Mjyp10WlfiNhvBxisB6SY9tLylDMq330\nfC86Zv3vDuCmiyDs/DxNaMjA3wEZdewkp7PLAuJiJ0TIKtmJSyF4GzC418ccr0Ab\nzfrf2DY8vwKBgGddQPELHt7YmbNkxqO8Iqjgs77i6s7Y9c8TxXPN/YZc4VhQE10b\nAX2Q0WnxaNQo8uZ6+QmO5tEFJllvjM69Qk4qhjzKpSna9P/DNS9+IFufOWgfJrUd\nx9QDRdur0f5BPVoaH9qF+23uFeC7m2MU1iahSd8TBRrGZM/dDzg40PNlAoGAREIC\n7P/lm9CfasA6hqUZMe2o1lUNtlgpSandvAqWubJ1kQK1ExQjrzIK7Pf5spTRgdxh\nXW9NRDh2AGJsyBHmy3PuJSfKIR03hbHNkczzm+tkFcD9WmYJE4t/F0b0P+65VHoI\nzMEH0gYFPq7yyUX6vOUywfP0fo67KmkfIHN0iW8CgYEA5uOKLinA27qdElrPaDPU\nXTnAke269prOBBlo1SGpWmi3FbINSLERr/q3A8JRT+cHxbvRLWWbJPw5kmoMJe2y\nFJHZDzbVvBCEfbXoEPRVel72zMyioOWW6fcRn6ISUn/FWqeH/+Gmo2kI52SFCKMw\nNQZ/zVpQJm/lBo80xLM3xNY=\n-----END PRIVATE KEY-----\n",
            "client_email":
                "firebase-adminsdk-fbsvc@ringlink-v1-mvp.iam.gserviceaccount.com",
            "client_id": "105754059741752131151",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url":
                "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url":
                "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40ringlink-v1-mvp.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          },
        ),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;

    return accessServerKey;
  }
}
