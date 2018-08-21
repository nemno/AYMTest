//
//  AYMSmallWeatherForecastView.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 21..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import SDWebImage

class AYMSmallWeatherForecastView: UIView {
    
    let dayLabel: UILabel
    let iconImageView: UIImageView
    let minTemperatureLabel: UILabel
    let maxTemperatureLabel: UILabel
    
    override init(frame: CGRect) {
        dayLabel = UILabel(frame: CGRect(x: 0.0, y: 10.0, width: frame.width, height: 30.0))
        dayLabel.textAlignment = .center
        dayLabel.font = .boldSystemFont(ofSize: 16.0)
        dayLabel.textColor = .black
        
        iconImageView = UIImageView(frame: CGRect(x: (frame.width - 30.0) / 2.0, y: dayLabel.frame.maxY + 10.0, width: 30.0, height: 30.0))
        
        maxTemperatureLabel = UILabel(frame: CGRect(x: 0.0, y: iconImageView.frame.maxY, width: frame.width / 2.0 - 2.0, height: 20.0))
        maxTemperatureLabel.textAlignment = .right
        maxTemperatureLabel.textColor = .black
        maxTemperatureLabel.font = .systemFont(ofSize: 10.0)
        
        minTemperatureLabel = UILabel(frame: CGRect(x: maxTemperatureLabel.frame.maxX + 4.0, y: iconImageView.frame.maxY, width: frame.width / 2.0 - 2.0, height: 20.0))
        minTemperatureLabel.textAlignment = .left
        minTemperatureLabel.textColor = .black
        minTemperatureLabel.font = .systemFont(ofSize: 10.0)
        minTemperatureLabel.alpha = 0.5
        
        super.init(frame: frame)
        
        self.addSubview(dayLabel)
        self.addSubview(iconImageView)
        self.addSubview(maxTemperatureLabel)
        self.addSubview(minTemperatureLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var weather: AYMDailyWeather? {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            if let dayDate = weather?.date {
                dayLabel.text = dateFormatter.string(from: dayDate)
            }
            
            iconImageView.sd_setImage(with: weather?.iconImageURL)
            
            if let minTemperature = weather?.minTemperature {
                minTemperatureLabel.text = String(format:"%.1f", minTemperature)
            }
            
            if let maxTemperature = weather?.maxTemperature {
                maxTemperatureLabel.text = String(format:"%.1f", maxTemperature)
            }
        }
    }

}
