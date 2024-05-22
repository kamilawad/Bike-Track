import { Test, TestingModule } from '@nestjs/testing';
import { getModelToken } from '@nestjs/mongoose';
import { UserService } from './user.service';
import { User, UserRole } from '../schemas/user.schema';
import { Model } from 'mongoose';

const mockUser = {
  _id: '1',
  fullName: 'Test User',
  email: 'test@example.com',
  password: 'password',
  role: 'user',
  followers: [],
  following: [],
  save: jest.fn().mockResolvedValue(this),
};

const mockUserModel = {
  new: jest.fn().mockResolvedValue(mockUser),
  constructor: jest.fn().mockResolvedValue(mockUser),
  create: jest.fn().mockImplementation((dto) => ({
    ...dto,
    _id: '1',
    save: jest.fn().mockResolvedValue({ ...dto, _id: '1' }),
  })),
  findById: jest.fn().mockReturnValue({
    exec: jest.fn().mockResolvedValue(mockUser),
  }),
  find: jest.fn().mockResolvedValue([mockUser]),
  findByIdAndDelete: jest.fn().mockResolvedValue(mockUser),
};

describe('UserService', () => {
  let service: UserService;
  let model: Model<User>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: getModelToken(User.name),
          useValue: mockUserModel,
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
    model = module.get<Model<User>>(getModelToken(User.name));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create a user', async () => {
    const createUserDto = {
      fullName: 'Test User',
      email: 'test@example.com',
      password: 'password',
      role: UserRole.USER,
    };

    const result = await service.createUser(createUserDto);
    expect(result).toEqual(expect.objectContaining(createUserDto));
  });

  it('should return all users', async () => {
    const result = await service.getUsers();
    expect(result).toEqual([mockUser]);
  });

  it('should return a user by id', async () => {
    const result = await service.getUserById('1');
    expect(result).toEqual(mockUser);
  });

  it('should delete a user', async () => {
    const result = await service.deleteUser('1');
    expect(result).toEqual(mockUser);
  });
});