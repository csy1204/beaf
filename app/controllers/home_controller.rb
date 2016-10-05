require 'rest-client'
require 'vine'
require 'nokogiri'
require 'open-uri'
require 'rufus-scheduler'
require 'libnotify'
require 'mailgun'

class HomeController < ApplicationController
  def index
i = 1
lala = 1



scheduler = Rufus::Scheduler.new
  
scheduler.every '3s' do

  [1,2,3].each do |c|
      @xml_doc  = Nokogiri::XML(open("https://www.xticket.co.kr/MPTicketing/InfoWS/INFO.asmx/GetSeatMapShort?scheduleId=226045&storeCd=01&zone=%EA%B0%80&story="+c.to_s+"&riaType=G"))
      
      @screen = @xml_doc.css('SeatShort')
      @screen.each do |s|
        unless s.css("sNm").inner_text == ""
            if (s.css("sYN").inner_text=="Y") && (s.css("gNm").inner_text=="인터넷")
                puts s.inner_text
                mg_client = Mailgun::Client.new("key-155e4eeb507734091129b3afac670bc3")
                message_params =  {
                                   from: 'whgofl4@naver.com',
                                   to: 'josang1204@gmail.com',
                                   subject: 'Lala land open!!',
                                   text: 'http://ticket.biff.kr/ko/reserve.aspx'+ ' ' + s.inner_text.to_s
                                  }
                
                result = mg_client.send_message('sandbox17622311ca6048dfbf7a84d22ec48697.mailgun.org', message_params).to_h!
                message_id = result['id']
                message = result['message']

            end
        end
      end
  
  end


  # @xml_doc  = Nokogiri::XML(open("https://www.xticket.co.kr/MPTicketing/InfoWS/INFO.asmx/GetSeatMapShort?scheduleId=226045&storeCd=01&zone=%EA%B0%80&story=1&riaType=G"))
  # @screen = @xml_doc.css('SeatShort')
  
  # @xml_doc1  = Nokogiri::XML(open("https://www.xticket.co.kr/MPTicketing/InfoWS/INFO.asmx/GetSeatMapShort?scheduleId=226045&storeCd=01&zone=%EA%B0%80&story=2&riaType=G"))
  # @screen1 = @xml_doc1.css('SeatShort')
  
  # @xml_doc2  = Nokogiri::XML(open("https://www.xticket.co.kr/MPTicketing/InfoWS/INFO.asmx/GetSeatMapShort?scheduleId=226045&storeCd=01&zone=%EA%B0%80&story=3&riaType=G"))
  # @screen2 = @xml_doc2.css('SeatShort')
  
  # @screen.each do |s|
  #   unless s.css("sNm").inner_text == ""
  #       if (s.css("sYN").inner_text=="Y") && (s.css("gNm").inner_text=="인터넷")
  #           puts s.inner_text
  #       end
  #   end
  # end
  
  # @screen1.each do |s|
  #   unless s.css("sNm").inner_text == ""
  #     if (s.css("sYN").inner_text=="Y") && (s.css("gNm").inner_text=="인터넷")
  #       puts s.inner_text
  #     end 
  #   end
  # end
  
  # @screen2.each do |s|
  #   unless s.css("sNm").inner_text == ""
  #       if (s.css("sYN").inner_text=="Y") && (s.css("gNm").inner_text=="인터넷")
  #           puts s.inner_text
  #       end
  #   end
  # end
  

  puts "beaf lala land" + i.to_s
  i+=1
  
end
    
scheduler.join
      
    
  end
  
  
end
