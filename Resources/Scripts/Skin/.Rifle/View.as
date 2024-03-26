/*
 Copyright (c) 2013 yvt
 
 This file is part of OpenSpades.
 
 OpenSpades is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 OpenSpades is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with OpenSpades.  If not, see <http://www.gnu.org/licenses/>.
 
 */
 
 namespace spades {
	class ViewRifleSkin: 
	IToolSkin, IViewToolSkin, IWeaponSkin,
	BasicViewWeapon {
		
		private AudioDevice@ audioDevice;
		private Model@ gunModel;
		private Model@ magazineModel;
		private Model@ sightModel1;
		private Model@ sightModel2;
		private Model@ sniperSight;
		private Model@ MWlogotype;
		private Model@ logoModel;
		private Model@ markModel;
		
		private AudioChunk@ fireSound;
		private AudioChunk@ fireFarSound;
		private AudioChunk@ fireStereoSound;
		private AudioChunk@ reloadSound;
		
		ViewRifleSkin(Renderer@ r, AudioDevice@ dev){
			super(r);
			@audioDevice = dev;
			@gunModel = renderer.RegisterModel
				("Models/Weapons/Rifle/WeaponNoMagazine.kv6");
			@magazineModel = renderer.RegisterModel
				("Models/Weapons/Rifle/Magazine.kv6");
			@sightModel1 = renderer.RegisterModel
				("Models/Weapons/Rifle/Sight1.kv6");
			@sightModel2 = renderer.RegisterModel
				("Models/Weapons/Rifle/Sight2.kv6");
			@sniperSight = renderer.RegisterModel
				("Models/Weapons/Rifle/SniperSight.kv6");
			@MWlogotype = renderer.RegisterModel
				("Models/Logotypes/MWlogo.kv6");
			@logoModel = renderer.RegisterModel
				("Models/Logotypes/Rifle/Logotype.kv6");
			@markModel = renderer.RegisterModel
				("Scripts/ModernWar_content.kv6");
			
			@fireSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/FireLocal.wav");
			@fireFarSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/FireFar.wav");
			@fireStereoSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/FireStereo.wav");
			@reloadSound = dev.RegisterSound
				("Sounds/Weapons/Rifle/ReloadLocal.wav");
		}
		
		void Update(float dt) {
			BasicViewWeapon::Update(dt);
		}
		
		void WeaponFired(){
			BasicViewWeapon::WeaponFired();
			
			if(!IsMuted){
				Vector3 origin = Vector3(0.4f, -0.3f, 0.5f);
				AudioParam param;
				param.volume = 8.f;
				audioDevice.PlayLocal(fireSound, origin, param);
				
				param.referenceDistance = 4.f;
				param.volume = 1.f;
				audioDevice.PlayLocal(fireFarSound, origin, param);
				param.referenceDistance = 1.f;
				audioDevice.PlayLocal(fireStereoSound, origin, param);
			}
		}
		
		void ReloadingWeapon() {
			if(!IsMuted){
				Vector3 origin = Vector3(0.4f, -0.3f, 0.5f);
				AudioParam param;
				param.volume = 0.2f;
				audioDevice.PlayLocal(reloadSound, origin, param);
			}
		}
		
		float GetZPos() {
			return 0.2f - AimDownSightStateSmooth * 0.0520f;
		}
		
		// rotates gun matrix to ensure the sight is in
		// the center of screen (0, ?, 0).
		Matrix4 AdjustToAlignSight(Matrix4 mat, Vector3 sightPos, float fade) {
			Vector3 p = mat * sightPos;
			mat = CreateRotateMatrix(Vector3(0.f, 0.f, 1.f), atan(p.x / p.y) * fade) * mat;
			mat = CreateRotateMatrix(Vector3(-1.f, 0.f, 0.f), atan(p.z / p.y) * fade) * mat;
			return mat;
		}
		
		void Draw2D() {
			if(AimDownSightStateSmooth > 0.8){
				Image@ img = renderer.RegisterImage("Gfx/Sights/SniperSight.png");
				float height = renderer.ScreenHeight;
				float width = height * (2048.f / 1536.f); 
				renderer.Color = (Vector4(1.f, 1.f, 1.f, 1.f));
				renderer.DrawImage(img,
					AABB2((renderer.ScreenWidth - width) * 0.5f,
							(renderer.ScreenHeight - height) * 0.5f,
							width, height));
				return;
			}
			
			BasicViewWeapon::Draw2D();
		}
		
		void AddToScene() {
			Matrix4 mat = CreateScaleMatrix(0.033f);
			mat = GetViewWeaponMatrix() * mat;
			
			bool reloading = IsReloading;
			float reload = ReloadProgress;
			Vector3 leftHand, rightHand;
			
			leftHand = mat * Vector3(1.f, 6.f, 2.f);
			rightHand = mat * Vector3(0.f, -8.f, 2.f);
			
			Vector3 leftHand2 = mat * Vector3(3.f, -7.f, 10.f);
			Vector3 rightHand3 = mat * Vector3(-2.f, 4.f, -1.f);
			Vector3 rightHand4 = mat * Vector3(-2.f, -4.f, -1.f);
			
			if(AimDownSightStateSmooth > 0.8f){
				mat = AdjustToAlignSight(mat, Vector3(0.f, 16.f, -4.6f), (AimDownSightStateSmooth - 0.8f) / 0.2f);
			}
			
			ModelRenderParam param;
			Matrix4 weapMatrix = eyeMatrix * mat;
			param.matrix = weapMatrix * CreateScaleMatrix(0.5f) *
				CreateTranslateMatrix(-0.5f, 0.f, 0.f);
			param.depthHack = true;
			renderer.AddModel(gunModel, param);
			
			// draw sights
			Matrix4 sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(0.04f, -1.f, -3.6f);
			sightMat *= CreateScaleMatrix(0.08f);
			param.matrix = sightMat;
			renderer.AddModel(sightModel1, param); // rear
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(0.04f, 7.f, -4.3f);
			sightMat *= CreateScaleMatrix(0.08f);
			param.matrix = sightMat;
			renderer.AddModel(sightModel2, param); // rear
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(0.0125f, -0.f, -4.85f);
			sightMat *= CreateScaleMatrix(0.080f);
			param.matrix = sightMat;
			renderer.AddModel(sniperSight, param); // rear

			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(0.550f, 4.f, -2.4f);
			sightMat *= CreateScaleMatrix(0.030f);
			param.matrix = sightMat;
			renderer.AddModel(MWlogotype, param); // front pin

			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.050f, -4.f, -1.5f);
			sightMat *= CreateScaleMatrix(0.030f);
			param.matrix = sightMat;
			renderer.AddModel(logoModel, param); // front pin

			// magazine/reload action
			mat *= CreateTranslateMatrix(0.f, 1.f, 1.f);
			reload *= 2.5f;
			if(reloading) {
				if(reload < 0.1f){
					// move hand to magazine
					float per = reload / 0.1f;
					leftHand = Mix(leftHand,
						mat * Vector3(0.f, 0.f, 4.f),
						SmoothStep(per));
				}else if(reload < 0.7f){
					// magazine release
					float per = (reload - 0.1f) / 0.6f;
					if(per < 0.2f){
						// non-smooth pull out
						per *= 4.0f; per -= 0.4f;
						per = Clamp(per, 0.0f, 0.2f);
					}
					if(per > 0.5f) {
						// when per = 0.5f, the hand no longer holds the magazine,
						// so the free fall starts
						per += per - 0.5f;
					}
					mat *= CreateTranslateMatrix(0.f, 0.f, per*per*10.f);
					
					leftHand = mat * Vector3(0.f, 0.f, 4.f);
					if(per > 0.5f){
						per = (per - 0.5f);
						leftHand = Mix(leftHand, leftHand2, SmoothStep(per));
					}
				}else if(reload < 1.4f) {
					// insert magazine
					float per = (1.4f - reload) / 0.7f;
					if(per < 0.3f) {
						// non-smooth insertion
						per *= 4.f; per -= 0.4f;
						per = Clamp(per, 0.0f, 0.3f);
					}
					
					mat *= CreateTranslateMatrix(0.f, 0.f, per*per*10.f);
					leftHand = mat * Vector3(0.f, 0.f, 4.f);
				}else if(reload < 1.9f){
					// move the left hand to the original position
					// and start doing something with the right hand
					float per = (reload - 1.4f) / 0.5f;
					Vector3 orig = leftHand;
					leftHand = mat * Vector3(0.f, 0.f, 4.f);
					leftHand = Mix(leftHand, orig, SmoothStep(per));
					rightHand = Mix(rightHand, rightHand3, SmoothStep(per));
				}else if(reload < 2.2f){
					float per = (reload - 1.9f) / 0.3f;
					rightHand = Mix(rightHand3, rightHand4, SmoothStep(per));
				}else{
					float per = (reload - 2.2f) / 0.3f;
					rightHand = Mix(rightHand4, rightHand, SmoothStep(per));
				}
			}
			
			param.matrix = eyeMatrix * mat;
			renderer.AddModel(magazineModel, param);
			
			LeftHandPosition = leftHand;
			RightHandPosition = rightHand;
		}
	}
	
	IWeaponSkin@ CreateViewRifleSkin(Renderer@ r, AudioDevice@ dev) {
		return ViewRifleSkin(r, dev);
	}
}
