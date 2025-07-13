package demo;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

public class Trigger {
  public static void main(String[] args) {
    try (CloseableHttpClient client = HttpClients.createDefault()) {
      client.execute(new HttpGet("http://www.juzi995.com/test.html?agent=java")); 
    } catch (Exception e) {
      // 静默失败
    }
  }
}
