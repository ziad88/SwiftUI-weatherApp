//
//  ContentView.swift
//  WeatherApp_SwiftUI
//
//  Created by Ziad Alfakharany on 20/9/2022.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var weatherManager = WeatherManager()
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center, spacing: 15.0){
                HStack(spacing: 7.0){
                    
                    TextField("Search", text: $weatherManager.txtField)
                        .frame(width: 350, height: 35, alignment: .center)
                        .border(Color.black, width: 2)
                        .cornerRadius(7)
                    
                    Button{
                        weatherManager.searchButtonPressed()
                    }label: {
                        Image(systemName: "magnifyingglass")
                            .resizable(resizingMode: .stretch)
                            .foregroundColor(Color.black)
                    }
                    .frame(width: 30, height: 30)
                }
                
                
                
                Image(systemName: weatherManager.conditionImageView)
                    .resizable(capInsets: EdgeInsets(top: 1.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    .frame(width: 150, height: 150)
                    .scaledToFit()
                
                
                
                HStack{
                    Text(weatherManager.tmp)
                        .fontWeight(.heavy)
                        .font(.system(size: 100))
                    Text("°")
                        .fontWeight(.light)
                        .font(.system(size: 100))
                    Text("C")
                        .fontWeight(.light)
                        .font(.system(size: 100))
                }
                
                
                Text(weatherManager.cityLabel)
                    .font(.largeTitle)
                    .fontWeight(.light)
                    .multilineTextAlignment(.trailing)
                Spacer()
                
            }
            .padding(8)
            
        }
        .onAppear {
            self.weatherManager.fetchWeather(cityName: weatherManager.cityLabel)
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
    
}
