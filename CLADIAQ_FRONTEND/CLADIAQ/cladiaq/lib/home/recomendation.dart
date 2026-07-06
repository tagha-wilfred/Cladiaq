import 'dart:math';

List<String> getAQIRecommendations(int aqi) {
  List<String> recommendations = [];

  if (aqi >= 0 && aqi <= 50) {
    recommendations = [
      "The air quality is great indoors, feel free to carry on with your tasks comfortably in this space.",
      "No concerns with air quality here; the indoor environment is clean and healthy for work or relaxation.",
      "You’re in a safe space with excellent air quality, no adjustments needed for now.",
      "Indoor air is fresh and pollutant-free, so you can comfortably stay here for longer periods.",
      "The room is in great shape air-wise, perfect for focusing or socializing without concerns."
    ];
  } else if (aqi >= 51 && aqi <= 100) {
    recommendations = [
      "Air quality is good for most, but it’s a good idea to ensure some ventilation if sensitive.",
      "Most will be fine indoors, though those sensitive to air might want to open windows or use a fan.",
      "It’s a comfortable environment, but slightly improving airflow can help for sensitive people.",
      "Generally fine, but if you have allergies, slight ventilation can make things more comfortable.",
      "Safe for most, but consider a fan or open window if staying long or if you’re sensitive."
    ];
  } else if (aqi >= 101 && aqi <= 150) {
    recommendations = [
      "Air quality isn’t ideal for sensitive groups. Improve ventilation and consider using an air purifier.",
      "If you’re sensitive to air quality, reduce your time in this room or enhance airflow.",
      "Ventilation is key now. Air quality isn’t optimal for vulnerable people, so improve air circulation.",
      "Sensitive individuals might experience discomfort. Airflow and purification can help a lot.",
      "Increase ventilation and reduce time in this space if you have asthma or other sensitivities."
    ];
  } else if (aqi >= 151 && aqi <= 200) {
    recommendations = [
      "Air quality is unhealthy indoors. Use air purifiers and try to limit your time in the room.",
      "Poor air quality for all occupants. Run an air purifier and avoid staying here long.",
      "This indoor air is unhealthy. Try enhancing ventilation and limit the time you spend here.",
      "Everyone should minimize time indoors. Air purifiers and fresh air circulation are recommended.",
      "Consider leaving this room temporarily. Ensure the air quality improves before returning."
    ];
  } else if (aqi >= 201 && aqi <= 300) {
    recommendations = [
      "Very unhealthy air inside. Minimize indoor activity and prioritize ventilation or air filtration.",
      "Everyone should limit time indoors. Improve air quality with purifiers or ventilation immediately.",
      "The air quality is dangerous. Leave the room if possible and use air purifiers.",
      "Indoor air is extremely unhealthy. Exit the room, increase airflow, and run purifiers.",
      "Air quality is very poor. Stay outside the room until conditions improve significantly."
    ];
  } else if (aqi >= 301 && aqi <= 500) {
    recommendations = [
      "Hazardous air indoors. Leave the room immediately and run all air purification systems.",
      "Air is dangerously polluted. Evacuate the room and improve air quality before re-entering.",
      "Extremely hazardous air. Exit the space immediately and ensure proper air filtration.",
      "Air quality is critically bad. Avoid this space completely until the air is purified.",
      "Immediate evacuation needed. Do not stay indoors until the air quality has improved drastically."
    ];
  }

  // Randomly select two recommendations from the list
  var random = Random();
  List<String> selectedRecommendations = [];

  if (recommendations.isNotEmpty) {
    selectedRecommendations
        .add(recommendations[random.nextInt(recommendations.length)]);
    selectedRecommendations
        .add(recommendations[random.nextInt(recommendations.length)]);
  }

  return selectedRecommendations;
}
