local DefaultConfigurations={
    EntityConfigurations={
        RushConfiguration={
            EntityID='11438133868';
            EntityName={
                true;
                'NewRush';
            };
            DeathCause={
                true;
                'Rush';
            };
            EntitySpeed=100;
            Timing=1;
            HeightOffset=0;
            AbleToJumpscare=true;
            JumpscareRange=25;
            SpawnFrontwards=false;
            ShatterLights=true;
            FlickLights={
                true;
                1;
            };
            CameraShaking={
                true;
                {15,25,.1,.2};
                50;
            };
            Rebounds={
                true;
                Minimal=1;
                Maximal=1;
                ReboundTiming=1;
            };
            Crucifixing={
                true;
                UseChains=true;
                ChainsID;
                ChainsOffset=3.096;
                ResistToChains=false;
                BreakCrucifix=true;
                Timing=2;
            };
            Jumpscare={
                true;
                JumpscareType='Rush';
                Table={
                    ImageID1='11715753154';
                    ImageID2='12243791457';
                    SoundID1={
                        0;
                        {
                            Volume=0;
                        };
                    };
                    SoundID2={
                        0;
                        {
                            Volume=0;
                        };
                    };
                    Flashing={
                        true;
                        Color3.fromRGB(0,0,255);
                    };
                    Shaking={
                        true;
                        {15,25,.1,.2};
                    };
                    Teasing={
                        true;
                        Minimal=1;
                        Maximal=2;
                        TeaseTiming=1;
                    };
                };
            };
            Messages={
                true;
                'GuidingLight';
                {
                    'suck balls.';
                };
            };
        };
        AmbushConfiguration={
            EntityID='12596057428';
            EntityName={
                true;
                'NewAmbush';
            };
            DeathCause={
                true;
                'Ambush';
            };
            EntitySpeed=100;
            Timing=1;
            HeightOffset=0;
            CanKill=true;
            SpawnFrontwards=false;
            BreakLights=true;
            FlickLights={
                true;
                1;
            };
            CameraShaking={
                true;
                {15,25,.1,.2};
                50;
            };
            Rebounds={
                true;
                Minimal=2;
                Maximal=4;
                ReboundTiming=1;
            };
            Jumpscare={
                true;
                'Ambush';
                ImageID1='11746956547';
                ImageID2='11746956547';
                SoundID1={
                    0;
                    {
                        Volume=0;
                    };
                };
                SoundID2={
                    0;
                    {
                        Volume=0;
                    };
                };
                Flashing={
                    true;
                    Color3.fromRGB(0,255,0);
                };
                Shaking={
                    true;
                    {15,25,.1,.2};
                };
                Teasing={
                    true;
                    Minimal=-1;
                    Maximal=-1;
                    TeaseTiming=1;
                };
            };
            Messages={
                true;
                'GuidingLight';
                {
                    'suck balls.';
                };
            };
        };
        EyesConfiguration={
        };
        TimothyConfiguration={
        };
        ScreechConfiguration={
        };
        JackConfiguration={
        };
        ShadowConfiguration={
        };
        WindowConfiguration={
        };
        GlitchConfiguration={
        };
        HaltConfiguration={
        };
        SeekConfiguration={
        };
        DupeConfiguration={
        };
        FigureConfiguration={
        };
        A60Configuration={
        };
        A120Configuration={
        };
    };
    ItemConfiguration={
        ItemID;
        ImageID='rbxassetid://9994899589';
        ItemName='Lighter';
        ItemDescription='Basic temporary light source';
        Price={
            true;
            50;
        };
        Stack={
            true;
            'x1';
        };
    };
    AchievementConfiguration={
        ImageID={
            true;
            'rbxassetid://10546856417';
        };
        Details={
            true;
            Title='Out Of My Way';
            Description="I'm walkin' here!";
            Reason='Successfuly survive Rush.';
        };
    };
};
return DefaultConfigurations;
