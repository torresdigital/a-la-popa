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
	class ViewShotgunSkin: 
	IToolSkin, IViewToolSkin, IWeaponSkin,
	BasicViewWeapon {
		
		private AudioDevice@ audioDevice;
		private Model@ gunModel;
		private Model@ pumpModel;
		private Model@ sightModel1;
		private Model@ MWlogotype;
		private Model@ logoModel;
		private Model@ slug;
		private Model@ markModel;
		
		private AudioChunk@ fireSound;
		private AudioChunk@ reloadSound;
		private AudioChunk@ cockSound;
		
		ViewShotgunSkin(Renderer@ r, AudioDevice@ dev){
			super(r);
			@audioDevice = dev;
			@gunModel = renderer.RegisterModel
				("Models/Weapons/Shotgun/WeaponNoPump.kv6");
			@pumpModel = renderer.RegisterModel
				("Models/Weapons/Shotgun/Pump.kv6");
			@sightModel1 = renderer.RegisterModel
				("Models/Weapons/Shotgun/Sight1.kv6");
			@slug = renderer.RegisterModel
				("Models/Weapons/Shotgun/Slug.kv6");
			@MWlogotype = renderer.RegisterModel
				("Models/Logotypes/MWlogo.kv6");
			@logoModel = renderer.RegisterModel
				("Models/Logotypes/Shotgun/Logotype.kv6");
			@markModel = renderer.RegisterModel
				("Scripts/ModernWar_content.kv6");
				
			@fireSound = dev.RegisterSound
				("Sounds/Weapons/Shotgun/Fire.wav");
			@reloadSound = dev.RegisterSound
				("Sounds/Weapons/Shotgun/Reload.wav");
			@cockSound = dev.RegisterSound
				("Sounds/Weapons/Shotgun/Cock.wav");
		}
		
		void Update(float dt) {
			BasicViewWeapon::Update(dt);
		}
		
		void WeaponFired(){
			BasicViewWeapon::WeaponFired();
			
			if(!IsMuted){
				Vector3 origin = Vector3(0.f, -0.3f, 0.5f);
				AudioParam param;
				param.volume = 8.f;
				audioDevice.PlayLocal(fireSound, origin, param);
			}
		}
		
		void ReloadingWeapon() {
			if(!IsMuted){
				Vector3 origin = Vector3(0.f, -0.3f, 0.5f);
				AudioParam param;
				param.volume = 0.2f;
				audioDevice.PlayLocal(reloadSound, origin, param);
			}
		}
		
		void ReloadedWeapon() {
			if(!IsMuted){
				Vector3 origin = Vector3(0.f, -0.3f, 0.5f);
				AudioParam param;
				param.volume = 0.2f;
				audioDevice.PlayLocal(cockSound, origin, param);
			}
		}
		
		float GetZPos() {
			return 0.2f - AimDownSightStateSmooth * 0.0535f;
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
			if(AimDownSightState > 0.6)
				return;
			BasicViewWeapon::Draw2D();
		}
		
		void AddToScene() {
			Matrix4 mat = CreateScaleMatrix(0.033f);
			mat = GetViewWeaponMatrix() * mat;
			
			bool reloading = IsReloading;
			float reload = ReloadProgress;
			Vector3 leftHand, rightHand;
			
			rightHand = mat * Vector3(0.f, -8.f, 2.f);
			
			Vector3 leftHand2 = mat * Vector3(5.f, -5.f, 4.f); //-10
			Vector3 leftHand3 = mat * Vector3(1.f, 6.f, 2.f); //1
			
			if(AimDownSightStateSmooth > 0.8f){
				mat = AdjustToAlignSight(mat, Vector3(0.f, 8.5f, -4.4f), 
					(AimDownSightStateSmooth - 0.8f) / 0.2f);
			}
			
			ModelRenderParam param;
			Matrix4 weapMatrix = eyeMatrix * mat;
			param.matrix = weapMatrix * CreateScaleMatrix(0.5f);
			param.depthHack = true;
			renderer.AddModel(gunModel, param);
			
			// draw sights	
			Matrix4 sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(0.025f, 5.0f, -4.4f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(sightModel1, param); // front pin
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.5f, -6.0f, -1.9f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(slug, param); // front pin
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.5f, -5.0f, -1.9f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(slug, param); // front pin
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.5f, -4.0f, -1.9f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(slug, param); // front pin
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.5f, -3.0f, -1.9f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(slug, param); // front pin
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.5f, -2.0f, -1.9f);
			sightMat *= CreateScaleMatrix(0.05f);
			param.matrix = sightMat;
			renderer.AddModel(slug, param); // front pin

			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.050f, -0.3f, -3.0f);
			sightMat *= CreateScaleMatrix(0.03f);
			param.matrix = sightMat;
			renderer.AddModel(MWlogotype, param); // rear
			
			sightMat = weapMatrix;
			sightMat *= CreateTranslateMatrix(1.050f, -1.8f, -3.0f);
			sightMat *= CreateScaleMatrix(0.03f);
			param.matrix = sightMat;
			renderer.AddModel(logoModel, param); // rear
			
			// reload action
			reload *= 0.5f;
			leftHand = mat * Vector3(0.f, 9.f, 2.f);
			
			if(reloading) {
				if(reload < 0.2f) {
					float per = reload / 0.2f;
					leftHand = Mix(leftHand, leftHand2,
						SmoothStep(per));
				}else if(reload < 0.35f){
					float per = (reload - 0.2f) / 0.15f;
					leftHand = Mix(leftHand2, leftHand3,
						SmoothStep(per));
				}else if(reload < 0.5f){
					float per = (reload - 0.35f) / 0.15f;
					leftHand = Mix(leftHand3, leftHand,
						SmoothStep(per));
				}
			}
			
			// motion blending parameter
			float cockFade = 1.f;
			if(reloading)	//will it need pump after reloading (yes if full)
			{
				if(reload < 0.25f || ammo < (clipSize - 1)) 
				{
					cockFade = 0.f;	
				}
				else
				{
					cockFade = (reload - 0.25f) * 10.f;
					cockFade = Min(cockFade, 1.f);
				}
			}
			
			if(cockFade > 0.f)	//does this if reloaded to full
			{
				float cock = 0.f;
				float tim = 1.f - readyState;
				if(tim < 0.f)
				{
					// might be right after reloading
					if(ammo >= clipSize && reload > 0.5f && reload < 1.f)
					{
						tim = reload - 0.5f;
						if(tim < 0.05f)			//dont start pumping too early
						{
							cock = 0.f;
						}
						else if(tim < 0.12f)
						{
							cock = (tim - 0.05f) / 0.07f;	//start pumping
						}
						else if(tim < 0.26f)
						{
							cock = 1.f;			//fully pumped
						}
						else if(tim < 0.36f)
						{
							cock = 1.f - (tim - 0.26f) / 0.1f;		//go back
						}
					}
				}
				else if(tim < 0.2f) //waiting
				{
					cock = 0.f;
				}
				else if(tim < 0.3f)	//start pumping
				{
					cock = (tim - 0.2f) / 0.1f;
				}
				else if(tim < 0.42f) //full pumped
				{
					cock = 1.f;
				}
				else if(tim < 0.52f) //go back
				{
					cock = 1.f - (tim - 0.42f) / 0.1f;
				}
				else //do nothing
				{
					cock = 0.f;
				}
				
				cock *= cockFade;
				mat = mat * CreateTranslateMatrix(0.f, cock * -3.5f, 0.f);
				
				//cock is just a float number impacting the rear/forward motion of pump
				
				leftHand = Mix(leftHand,
					mat * Vector3(0.f, 4.f, 2.f), cockFade);
			}
			
			param.matrix = eyeMatrix * mat * CreateScaleMatrix(0.5f);
			renderer.AddModel(pumpModel, param);
			
			LeftHandPosition = leftHand;
			RightHandPosition = rightHand;
		}
	}
	
	IWeaponSkin@ CreateViewShotgunSkin(Renderer@ r, AudioDevice@ dev) {
		return ViewShotgunSkin(r, dev);
	}
}
