class Client {
	static boxCors := {}
	static shipStatsBoxCors := {}
	static bonusBoxShader := 130
	static statsBoxShader := 15
	static bonusBoxSize := 0
	static searchBoxsSize := [{}, {}, {}, {}]

	__New() {
		this.setClientCors()
		this.setShipStatsBoxCors()
		this.setBonusBoxSize()
		this.setSearchBoxsSize()
	}

	setClientCors() {
		TrayTip, Configuracion, Colocar puntero sobre esquina SUPERIOR del juego y presionar Numpad8, 10000
		KeyWait, Numpad8, D


		MouseGetPos, corsX, corsY
		this.boxCors.x1 := 0
		this.boxCors.y1 := corsY

		TrayTip, Configuracion, Colocar puntero sobre esquina INFERIOR del juego y presionar Numpad2, 10000
		KeyWait, Numpad2, D

		MouseGetPos, corsX, corsY
		this.boxCors.x2 := A_ScreenWidth
		this.boxCors.y2 := corsY
	}

	setSearchBoxsSize() {
		this.searchBoxsSize[1].x1 := this.boxCors.x1
		this.searchBoxsSize[1].y1 := this.boxCors.y1
		this.searchBoxsSize[1].x2 := this.boxCors.x2
		this.searchBoxsSize[1].y2 := (this.boxCors.y2 * 0.6150) - (this.bonusBoxSize * 0.50)

		this.searchBoxsSize[2].x1 := this.boxCors.x1
		this.searchBoxsSize[2].y1 := (this.boxCors.y2 * 0.6150) + (this.bonusBoxSize * 0.50)
		this.searchBoxsSize[2].x2 := this.boxCors.x2
		this.searchBoxsSize[2].y2 := this.boxCors.y2 

		this.searchBoxsSize[3].x1 := this.boxCors.x1
		this.searchBoxsSize[3].y1 := (this.boxCors.y2 * 0.30)
		this.searchBoxsSize[3].x2 := (this.boxCors.x2 * 0.50) - (this.bonusBoxSize * 0.50)
		this.searchBoxsSize[3].y2 := this.boxCors.y2

		this.searchBoxsSize[4].x1 := (this.boxCors.x2 * 0.50) + (this.bonusBoxSize * 0.50)
		this.searchBoxsSize[4].y1 := (this.boxCors.y2 * 0.30)
		this.searchBoxsSize[4].x2 := this.boxCors.x2
		this.searchBoxsSize[4].y2 := this.boxCors.y2
	}

	setBonusBoxSize() {
		this.bonusBoxSize := this.boxCors.x2 * 0.0650
	}

	searchBonusBox() {
		shaderVariation := this.bonusBoxShader
		i := 1

		Loop, 4 {
			ImageSearch, corsX, corsY, this.searchBoxsSize[i].x1, this.searchBoxsSize[i].y1, this.searchBoxsSize[i].x2, this.searchBoxsSize[i].y2 , *%shaderVariation% ./img/bonus_box.bmp

			if (ErrorLevel = 0) {
				return [corsX, corsY]
			} 

			i++
		}

		return false
	}


	setShipStatsBoxCors() {
		shaderVariation := 15

		ImageSearch, corsX, corsY, this.boxCors.x1, this.boxCors.y1, this.boxCors.x2, this.boxCors.y2, *%shaderVariation% ./img/ship_stats_box.bmp

		If (ErrorLevel = 0) {
			this.shipStatsBoxCors.x1 := corsX
			this.shipStatsBoxCors.y1 := corsY
			this.shipStatsBoxCors.x2 := corsX + 190
			this.shipStatsBoxCors.y2 := corsY + 105
		} else {
			TrayTip, ERROR!, No se encuentra el estado de la nave
			Sleep, 5000
		}
	}
}