//
//  ViewController.swift
//  weather app
//
//  Created by Jonatas Falkaniere on 05/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    private let forecastModel = ForecastModel()
    private let mainView = MainView()
 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    private func fetchData() {
        forecastModel.fetchData(city: DefaultCityData.city)
    }
    
    private func loadData() {
        mainView.cityHeaderLabel.text = DefaultCityData.city.name
        mainView.tempLabel.text = forecastModel.forecastResponse?.current.temp.toCelsius()
        mainView.humidityValueLabel.text = "\(forecastModel.forecastResponse?.current.humidity ?? 0) mm"
        mainView.windValueLabel.text = "\(forecastModel.forecastResponse?.current.windSpeed ?? 0.0)km/h"
        mainView.backgroundView.image = forecastModel.forecastResponse?.current.dt.isDayTime() ?? true ? UIImage.backgroundDayImage : UIImage.backgroundNightImage
        mainView.weatherIcon.image = UIImage(named: forecastModel.forecastResponse?.current.weather.first?.icon ?? "")
        mainView.headerView.backgroundColor = forecastModel.forecastResponse?.current.dt.isDayTime() ?? true ? UIColor.headerColor : UIColor.softGray
        mainView.cityHeaderLabel.textColor = forecastModel.forecastResponse?.current.dt.isDayTime() ?? true ? UIColor.textPrimaryColor : UIColor.headerColor
        mainView.tempLabel.textColor = forecastModel.forecastResponse?.current.dt.isDayTime() ?? true ? UIColor.textPrimaryColor : UIColor.headerColor
        
        mainView.hourlyCollectionView.reloadData()
        mainView.dailyForecastTableView.reloadData()
    }

    private func setupView() {
        setHierarchy()
        setConstraints()
        
        mainView.setupHourlyCollectionViewDataSource(dataSource: self)
        mainView.setupDailyForecastTableViewDataSource(dataSource: self)
    }
    
    private func setHierarchy() {
        view.addSubview(mainView.backgroundView)
        view.addSubview(mainView.headerView)
        view.addSubview(mainView.statsStackView)
        view.addSubview(mainView.hourlyCollectionView)
        view.addSubview(mainView.hourlyLabel)
        view.addSubview(mainView.dailyForecastLabel)
        view.addSubview(mainView.dailyForecastTableView)
        
        mainView.headerView.addSubview(mainView.cityHeaderLabel)
        mainView.headerView.addSubview(mainView.tempLabel)
        mainView.headerView.addSubview(mainView.weatherIcon)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            mainView.backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            mainView.backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainView.headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            mainView.headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            mainView.headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            mainView.headerView.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        NSLayoutConstraint.activate([
            mainView.cityHeaderLabel.topAnchor.constraint(equalTo: mainView.headerView.topAnchor, constant: 15),
            mainView.cityHeaderLabel.leadingAnchor.constraint(equalTo: mainView.headerView.leadingAnchor, constant: 15),
            mainView.cityHeaderLabel.trailingAnchor.constraint(equalTo: mainView.headerView.trailingAnchor, constant: -15),
            mainView.cityHeaderLabel.heightAnchor.constraint(equalToConstant: 20),
            
            mainView.tempLabel.topAnchor.constraint(equalTo: mainView.cityHeaderLabel.bottomAnchor, constant: 12),
            mainView.tempLabel.leadingAnchor.constraint(equalTo: mainView.headerView.leadingAnchor, constant: 26),
            
            mainView.weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            mainView.weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            mainView.weatherIcon.trailingAnchor.constraint(equalTo: mainView.headerView.trailingAnchor, constant: -26),
            mainView.weatherIcon.leadingAnchor.constraint(equalTo: mainView.tempLabel.trailingAnchor, constant: 15),
            mainView.weatherIcon.centerYAnchor.constraint(equalTo: mainView.tempLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainView.statsStackView.topAnchor.constraint(equalTo: mainView.headerView.bottomAnchor, constant: 24),
            mainView.statsStackView.widthAnchor.constraint(equalToConstant: 206),
            mainView.statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainView.hourlyLabel.topAnchor.constraint(equalTo: mainView.statsStackView.bottomAnchor, constant: 29),
            mainView.hourlyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            mainView.hourlyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            
            mainView.hourlyCollectionView.topAnchor.constraint(equalTo: mainView.hourlyLabel.bottomAnchor, constant: 26),
            mainView.hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            mainView.hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            mainView.dailyForecastLabel.topAnchor.constraint(equalTo: mainView.hourlyCollectionView.bottomAnchor, constant: 29),
            mainView.dailyForecastLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            mainView.dailyForecastLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            
            mainView.dailyForecastTableView.topAnchor.constraint(equalTo: mainView.dailyForecastLabel.bottomAnchor, constant: 16),
            mainView.dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastModel.forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let forecast = forecastModel.forecastResponse?.hourly[indexPath.row]
        
        cell.loadData(
            time: forecast?.dt.toHourFormat(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? ""),
            temp: forecast?.temp.toCelsius())
        
        return cell
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection   section: Int) -> Int {
        return forecastModel.forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        
        let forecast = forecastModel.forecastResponse?.daily[indexPath.row]
        cell.loadData(
            weekDay: forecast?.dt.toWeekdayName().uppercased(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? ""),
            maxTemp: forecast?.temp.max.toCelsius(),
            minTemp: forecast?.temp.min.toCelsius()
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

