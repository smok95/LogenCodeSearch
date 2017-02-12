/*
 LogenCode, d0nzs00n@gmail.com
 
 Copyright (c) 2017, Kim,Jong-Kook
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are
 met:
 
 * Redistributions of source code must retain the above copyright
 notice, this list of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright
 notice, this list of conditions and the following disclaimer in the
 documentation and/or other materials provided with the distribution.
 * Neither the name of the <ORGANIZATION> nor the names of its
 contributors may be used to endorse or promote products derived from
 this software without specific prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
 OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import Foundation
import UIKit

class Branch:NSObject{
    let code:String         // 도착점 코드
    let area:String         // 관할지역 목록
    let city:String         // 권역(도시)
    let backColor:UIColor   // 배경색상
    
    init(code:String, city:String, area:String, backColor:String){
        self.code = code
        self.city = city
        self.area = area
        
        var rgb:UInt32 = 0
        Scanner(string: backColor).scanHexInt32(&rgb)
        
        let r = CGFloat( (rgb & 0xff0000)>>16 ) / 255.0
        let g = CGFloat( (rgb & 0x00ff00)>>8 ) / 255.0
        let b = CGFloat(rgb & 0x0000ff) / 255.0
        self.backColor = UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
