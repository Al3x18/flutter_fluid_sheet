import 'package:flutter/material.dart';

class RaceDetailsData extends StatelessWidget {
  const RaceDetailsData({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.light;
    final bool isLightMode = !isDark;

    const TextStyle listTileStyle = TextStyle(fontFamily: "Formula1", fontSize: 14);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.5, vertical: 0),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //MARK: Title
          Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Standard Race Weekend",
                style: listTileStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold, color: isLightMode ? Colors.red[800] : Colors.red[300]),
              ),
            ),
          ),

          //MARK: Race Sessions
          _buildRaceDetailSection("Race Schedule", "2024-03-24", "15:00", listTileStyle, isDark),
          _buildRaceDetailSection("Qualifying Session", "2024-03-23", "15:00", listTileStyle, isDark),
          _buildRaceDetailSection("FP1", "2024-03-22", "12:30", listTileStyle, isDark),
          _buildRaceDetailSection("FP2", "2024-03-22", "16:00", listTileStyle, isDark),
          _buildRaceDetailSection("FP3", "2024-03-23", "12:00", listTileStyle, isDark),

          //MARK: Divider
          Divider(thickness: 1, indent: 14, endIndent: 14, color: !isDark ? Colors.grey[300] : Colors.grey[600]),

          //MARK: Track Section
          _buildTrackSection(listTileStyle, isDark),

          //MARK: Divider
          Divider(thickness: 1, indent: 14, endIndent: 14, color: !isDark ? Colors.grey[300] : Colors.grey[600]),

          //MARK: Weather Section
          _buildWeatherSection(listTileStyle, isDark),

          const SizedBox(height: 45),
        ],
      ),
    );
  }

  //MARK: Build Race Detail Section
  Widget _buildRaceDetailSection(String title, String date, String time, TextStyle style, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: !isDark ? Colors.grey[300]! : Colors.grey[600]!),
        borderRadius: BorderRadius.circular(12),
        color: !isDark ? Colors.grey[50] : Colors.grey[800],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  title,
                  style: style.copyWith(fontWeight: FontWeight.bold, fontSize: 16, color: !isDark ? Colors.black87 : Colors.white),
                ),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Date",
                  style: style.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: !isDark ? Colors.grey[700] : Colors.grey[300]),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("SUNDAY, 24 MAR 2024", style: style.copyWith(fontSize: 12, color: !isDark ? Colors.grey[700] : Colors.grey[300])),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Start",
                  style: style.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: !isDark ? Colors.grey[700] : Colors.grey[300]),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  time,
                  style: style.copyWith(fontSize: 12, fontWeight: FontWeight.w600, color: !isDark ? Colors.grey[700] : Colors.grey[300]),
                ),
              ),
            ],
          ),

          //MARK: Results Button (only for race)
          if (title == "Race Schedule") ...[
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: ElevatedButton(
                onPressed: () {
                  // Dummy action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text("Show Race Results", style: style.copyWith(fontWeight: FontWeight.w600, fontSize: 12)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  //MARK: Build Track Section
  Widget _buildTrackSection(TextStyle listTileStyle, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: !isDark ? Colors.grey[300]! : Colors.grey[600]!),
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey[800] : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, color: !isDark ? Colors.red[800] : Colors.white, size: 20),
              const SizedBox(width: 8),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Track Map",
                  style: listTileStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: !isDark ? Colors.red[800] : Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.info_outline, size: 18, color: !isDark ? Colors.red[800] : Colors.white),
            ],
          ),
          const SizedBox(height: 16),

          // Dummy map container
          Container(
            width: double.infinity,
            height: 208,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDark ? Colors.grey[600]! : Colors.grey[300]!, width: 0.5),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 48, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  const SizedBox(height: 8),
                  Text("Circuit Map Preview", style: listTileStyle.copyWith(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 14)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Button to open circuit map
          SizedBox(
            width: double.infinity,
            height: 32,
            child: OutlinedButton.icon(
              onPressed: () {
                // Dummy action
              },
              icon: Icon(Icons.location_on_outlined, size: 16, color: !isDark ? Colors.red[800] : Colors.white),
              label: Text(
                "Open in Maps",
                style: listTileStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 12.2, color: !isDark ? Colors.red[800] : Colors.white),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: !isDark ? Colors.red[300]! : Colors.red[400]!, width: 1.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Credits
          Center(
            child: Text("Tap to view full screen", style: listTileStyle.copyWith(fontSize: 10, color: Colors.grey[500])),
          ),
        ],
      ),
    );
  }

  //MARK: Build Weather Section
  Widget _buildWeatherSection(TextStyle listTileStyle, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: !isDark ? Colors.grey[300]! : Colors.grey[600]!),
        borderRadius: BorderRadius.circular(12),
        color: isDark ? Colors.grey[800] : Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon, title and time
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(16)),
                child: Icon(Icons.wb_sunny, color: Colors.orange[600], size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Current Track Weather",
                        style: listTileStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                      ),
                    ),
                    Text(
                      "Track Time - 14:30",
                      style: listTileStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "CLEAR SKY",
            style: listTileStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.grey[600]),
          ),
          const SizedBox(height: 16),

          // Grid with main weather data
          Row(
            children: [
              Expanded(
                child: _buildWeatherCard(icon: Icons.thermostat, label: "Temperature", value: "22°C", listTileStyle: listTileStyle, isDark: isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildWeatherCard(icon: Icons.thermostat_outlined, label: "Feels Like", value: "24°C", listTileStyle: listTileStyle, isDark: isDark),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildWeatherCard(icon: Icons.water_drop, label: "Humidity", value: "65%", listTileStyle: listTileStyle, isDark: isDark),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildWeatherCard(icon: Icons.air, label: "Wind", value: "3.2 m/s", listTileStyle: listTileStyle, isDark: isDark),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Atmospheric pressure in separate card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? Colors.grey[700] : Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDark ? Colors.grey[600]! : Colors.grey[300]!, width: 0.5),
            ),
            child: Row(
              children: [
                Icon(Icons.speed, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Atmospheric Pressure",
                        style: listTileStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 12, color: Colors.grey[600]),
                      ),
                      Text(
                        "1013 hPa",
                        style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Credits
          Center(
            child: Text("Powered by OpenWeather", style: listTileStyle.copyWith(fontSize: 10, color: Colors.grey[500])),
          ),
        ],
      ),
    );
  }

  //MARK: Build Weather Card
  Widget _buildWeatherCard({required IconData icon, required String label, required String value, required TextStyle listTileStyle, required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[700] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isDark ? Colors.grey[600]! : Colors.grey[300]!, width: 0.5),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(height: 4),
          Text(
            label,
            style: listTileStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 11, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: listTileStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
