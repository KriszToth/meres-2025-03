using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;

public class Ad
{
    public int Id { get; set; }
    public int Rooms { get; set; }
    public string LatLong { get; set; }
    public int Floors { get; set; }
    public int Area { get; set; }
    public string Description { get; set; }
    public bool FreeOfCharge { get; set; }
    public string ImageUrl { get; set; }
    public DateTime CreateAt { get; set; }
    public Seller Seller { get; set; }
    public Category Category { get; set; }

    public double DistanceTo(double lat, double lon)
    {
        var coords = LatLong.Split(',').Select(c => double.Parse(c, CultureInfo.InvariantCulture)).ToArray();
        double lat1 = coords[0];
        double lon1 = coords[1];
        return Math.Sqrt(Math.Pow(lat1 - lat, 2) + Math.Pow(lon1 - lon, 2));
    }
}

public class Seller
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Phone { get; set; }
}

public class Category
{
    public int Id { get; set; }
    public string Name { get; set; }
}

public static class AdLoader
{
    public static List<Ad> LoadFromCsv(string filePath)
    {
        var ads = new List<Ad>();
        var lines = File.ReadAllLines(filePath).Skip(1);

        foreach (var line in lines)
        {
            var parts = line.Split(';');
            var ad = new Ad
            {
                Id = int.Parse(parts[0]),
                Rooms = int.Parse(parts[1]),
                LatLong = parts[2],
                Floors = int.Parse(parts[3]),
                Area = int.Parse(parts[4]),
                Description = parts[5],
                FreeOfCharge = parts[6] == "1",
                ImageUrl = parts[7],
                CreateAt = DateTime.Parse(parts[8]),
                Seller = new Seller
                {
                    Id = int.Parse(parts[9]),
                    Name = parts[10],
                    Phone = parts[11]
                },
                Category = new Category
                {
                    Id = int.Parse(parts[12]),
                    Name = parts[13]
                }
            };
            ads.Add(ad);
        }

        return ads;
    }
}

class Program
{
    static void Main(string[] args)
    {
        var ads = AdLoader.LoadFromCsv("realestates.csv");

        // 6. feladat: Földszinti ingatlanok átlagos alapterülete
        var groundFloorAds = ads.Where(a => a.Floors == 0).ToList();
        var averageArea = groundFloorAds.Average(a => a.Area);
        Console.WriteLine($"1. feladat: Földszinti ingatlanok átlagos alapterülete: {averageArea:F2} m2");

        // 8. feladat: Legközelebbi tehermentes ingatlan a Mesevár óvodához
        var mesevarLat = 47.4164220114023;
        var mesevarLon = 19.066342425796986;
        var closestAd = ads
            .Where(a => a.FreeOfCharge)
            .OrderBy(a => a.DistanceTo(mesevarLat, mesevarLon))
            .FirstOrDefault();

        if (closestAd != null)
        {
            Console.WriteLine("2. feladat: Legközelebbi tehermentes ingatlan adatai:");
            Console.WriteLine($"\tEladó neve: {closestAd.Seller.Name}");
            Console.WriteLine($"\tEladó telefonja: {closestAd.Seller.Phone}");
            Console.WriteLine($"\tAlapterület: {closestAd.Area} m2");
            Console.WriteLine($"\tSzobák száma: {closestAd.Rooms}");
        }
        else
        {
            Console.WriteLine("8. feladat: Nincs tehermentes ingatlan a közelben.");
        }
    }
}