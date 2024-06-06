CREATE DATABASE IF NOT EXISTS urgentNews;

USE urgentNews;

CREATE TABLE News (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    timestamp DATETIME NOT NULL
);

INSERT INTO News (title, content, timestamp) VALUES
('Breaking: Global Cyberattack Targets Major Financial Institutions', 'A massive cyberattack has targeted major financial institutions worldwide, resulting in widespread disruption and security breaches. Authorities are investigating the incident and urging caution in online transactions.', '2022-05-15 14:06:16'),
('Urgent: Massive Earthquake Strikes Pacific Ring of Fire', 'A powerful earthquake with a magnitude of 7.8 has struck the Pacific Ring of Fire, causing extensive damage to several coastal regions. Rescue and relief efforts are underway.', '2023-04-11 15:14:01'),
('Emergency Alert: Deadly Outbreak of New Viral Strain Detected', 'Health officials have identified a new and highly contagious viral strain responsible for a deadly outbreak. Urgent measures are being taken to contain the spread and develop effective treatments.', '2023-08-05 12:06:13'),
('Breaking News: Terrorist Attack Rocks Capital City', 'A devastating terrorist attack has shaken the capital city, causing multiple casualties and widespread panic. Security forces are on high alert and conducting investigations.', '2023-05-15 14:06:16'),
('Urgent: Record-Breaking Heatwave Threatens Public Health', 'An unprecedented heatwave is gripping the region, with temperatures reaching dangerous levels. Public health advisories have been issued, urging residents to stay hydrated and seek shelter.', '2020-05-15 14:06:16'),
('Emergency Broadcast: Nuclear Plant Leak Prompts Evacuation', 'A leak has been detected at a nearby nuclear power plant, leading to the immediate evacuation of surrounding areas. Emergency response teams are working to mitigate the situation.', '2023-12-14 09:06:16'),
('Breaking: International Space Station Suffers Critical Systems Failure', 'The International Space Station (ISS) has experienced a critical systems failure, endangering the lives of astronauts onboard. Engineers are working to restore functionality and ensure their safe return.', '2023-01-11 06:06:00'),
('Urgent Update: World Leaders Summit Canceled Due to Security Threat', 'Due to a credible security threat, the highly anticipated world leaders summit has been canceled. Security agencies are investigating the threat and implementing heightened security measures.', '2022-07-17 11:08:16'),
('Emergency Advisory: Category 5 Hurricane Approaching Coastal Regions', 'A Category 5 hurricane is rapidly approaching coastal regions, posing a severe threat to life and property. Evacuation orders have been issued, and emergency response teams are mobilizing.', '2023-06-10 12:06:16'),
('Breaking News: Major Airline Grounds Fleet Amidst Safety Concerns', 'A major airline has made the decision to ground its entire fleet following safety concerns. Passengers are advised to check for updates and make alternative travel arrangements.', '2023-05-15 14:10:16')