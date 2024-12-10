using System;
using System.Net.Http;
using System.Text.Json;
using System.Threading.Tasks;

class Program
{
    static readonly HttpClient client = new HttpClient();

    static async Task Main()
    {
        try
        {
            client.DefaultRequestHeaders.Add("User-Agent", "C# console program");
            string responseBody = await client.GetStringAsync("https://api.github.com/orgs/dotnet/repos");
            Repository[] repositories = JsonSerializer.Deserialize<Repository[]>(responseBody);

            foreach (var repo in repositories)
            {
                Console.WriteLine($"Name: {repo.Name}");
                Console.WriteLine($"Description: {repo.Description}");
                Console.WriteLine($"GitHub URL: {repo.HtmlUrl}");
                Console.WriteLine($"Homepage: {repo.Homepage}");
                Console.WriteLine($"Watchers: {repo.Watchers}");
                Console.WriteLine($"Last Pushed: {repo.PushedAt}");
                Console.WriteLine();
            }
        }
        catch (HttpRequestException e)
        {
            Console.WriteLine("\nException Caught!");
            Console.WriteLine("Message :{0} ", e.Message);
        }
    }
}
